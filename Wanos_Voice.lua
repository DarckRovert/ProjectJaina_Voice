--[[
    ========================================================================
    Project Jaina - Sistema de Voz Espacial 3D y Proximidad (ProjectJaina_Voice.lua)
    Reino: Project Jaina | Servidor: Project Jaina Oficial
    Motor: World of Warcraft 3.3.5a (Build 12340)
    ========================================================================
    Módulo de Cliente Oficial #16: Renderizado visual de actividad de voz
    sobre placas de nombre 3D (Nameplates), retratos de unidad (UnitFrames) y
    gestión de enlace WebRTC con el Coordinador de Audio Espacial.
]]

local ADDON_NAME = "ProjectJaina_Voice"
local VERSION = "1.0.1"
local PREFIJO = "WP_VOICE"
local TIEMPO_VIDA = 2.5       -- Segundos sin paquete de refresco antes de apagar altavoz
local REFRESCO = 0.1          -- Tasa de muestreo de placas y marcos (10 Hz)
local TAMANO_ICONO = 28
local TEXTURA_ALTAVOZ = "Interface\\Common\\VoiceChat-Speaker"

----------------------------------------------------------------------------
--  Estado Local de Interlocutores
----------------------------------------------------------------------------
local hablando = {} -- [NombreJugador] = TimestampCaducidad

local function EstaHablando(nombre)
    if not nombre then return false end
    local caduca = hablando[nombre]
    if not caduca then return false end
    if GetTime() > caduca then
        hablando[nombre] = nil
        return false
    end
    return true
end

----------------------------------------------------------------------------
--  Factoría de Iconos de Altavoz (Z-Index Elevado)
----------------------------------------------------------------------------
local function CrearIcono(padre, tamano)
    local capa = CreateFrame("Frame", nil, padre)
    capa:SetWidth(tamano or TAMANO_ICONO)
    capa:SetHeight(tamano or TAMANO_ICONO)
    capa:SetFrameLevel(padre:GetFrameLevel() + 5)

    local t = capa:CreateTexture(nil, "OVERLAY")
    t:SetTexture(TEXTURA_ALTAVOZ)
    t:SetAllPoints(capa)

    capa:Hide()
    return capa
end

----------------------------------------------------------------------------
--  1. Placas de Nombre (Nameplates en Escena 3D)
----------------------------------------------------------------------------
local placasVistas = {}

local function EsPlacaDeNombre(marco)
    if marco:GetName() then return false end
    if marco._wpVoiceIsPlate ~= nil then return marco._wpVoiceIsPlate end
    for i = 1, select("#", marco:GetRegions()) do
        local reg = select(i, marco:GetRegions())
        if reg and reg.GetObjectType and reg:GetObjectType() == "Texture" then
            local tex = reg:GetTexture()
            if tex == "Interface\\Tooltips\\Nameplate-Border" then
                marco._wpVoiceIsPlate = true
                return true
            end
        end
    end
    marco._wpVoiceIsPlate = false
    return false
end

local function NombreDeLaPlaca(marco)
    if marco._wpVoiceNameText then
        return marco._wpVoiceNameText:GetText()
    end
    for i = 1, select("#", marco:GetRegions()) do
        local reg = select(i, marco:GetRegions())
        if reg and reg.GetObjectType and reg:GetObjectType() == "FontString" then
            marco._wpVoiceNameText = reg
            return reg:GetText()
        end
    end
    return nil
end

local function PrepararPlaca(marco)
    local icono = CrearIcono(marco)
    icono:SetPoint("BOTTOM", marco, "TOP", 0, -4)
    placasVistas[marco] = icono
    return icono
end

local algunIconoEnPlaca = false

local function RepasarPlacas()
    if not next(hablando) then
        if algunIconoEnPlaca then
            for marco, icono in pairs(placasVistas) do
                icono:Hide()
            end
            algunIconoEnPlaca = false
        end
        return
    end

    local numHijos = WorldFrame:GetNumChildren()
    for i = 1, numHijos do
        local marco = select(i, WorldFrame:GetChildren())
        if marco and EsPlacaDeNombre(marco) then
            local icono = placasVistas[marco] or PrepararPlaca(marco)
            if marco:IsShown() and EstaHablando(NombreDeLaPlaca(marco)) then
                icono:Show()
                algunIconoEnPlaca = true
            else
                icono:Hide()
            end
        end
    end
end

----------------------------------------------------------------------------
--  2. Marcos de Unidad (UnitFrames & Retratos)
----------------------------------------------------------------------------
local iconosUnidad = {}

local function IconoDeMarco(marco, nombreMarco)
    if not iconosUnidad[nombreMarco] then
        local icono = CrearIcono(marco, 26)
        local retrato = getglobal(nombreMarco .. "Portrait")
        if nombreMarco == "PlayerFrame" then retrato = getglobal("PlayerPortrait") end

        if retrato then
            icono:SetPoint("CENTER", retrato, "TOP", 0, 4)
        else
            icono:SetPoint("TOPLEFT", marco, "TOPLEFT", 30, 6)
        end
        iconosUnidad[nombreMarco] = icono
    end
    return iconosUnidad[nombreMarco]
end

local resplandorLocal

local function ObtenerResplandor()
    if not resplandorLocal then
        local capa = CreateFrame("Frame", nil, PlayerFrame)
        capa:SetFrameLevel(PlayerFrame:GetFrameLevel() + 4)
        capa:SetAllPoints(getglobal("PlayerPortrait") or PlayerFrame)

        local t = capa:CreateTexture(nil, "OVERLAY")
        t:SetTexture("Interface\\Buttons\\UI-ActionButton-Border")
        t:SetBlendMode("ADD")
        t:SetVertexColor(0.2, 0.9, 0.2)
        t:SetPoint("CENTER", capa, "CENTER", 0, 0)
        t:SetWidth(capa:GetWidth() * 2.1)
        t:SetHeight(capa:GetHeight() * 2.1)

        capa:Hide()
        resplandorLocal = capa
    end
    return resplandorLocal
end

local function RepasarUnidad(nombreMarco, unidad)
    local marco = getglobal(nombreMarco)
    if not marco or not marco:IsShown() then
        if iconosUnidad[nombreMarco] then iconosUnidad[nombreMarco]:Hide() end
        if nombreMarco == "PlayerFrame" then ObtenerResplandor():Hide() end
        return
    end

    local icono = IconoDeMarco(marco, nombreMarco)
    local habla = EstaHablando(UnitName(unidad))
    if habla then icono:Show() else icono:Hide() end

    if nombreMarco == "PlayerFrame" then
        if habla then ObtenerResplandor():Show() else ObtenerResplandor():Hide() end
    end
end

local algunIconoEnMarcos = false

local function RepasarMarcos()
    if not next(hablando) then
        if algunIconoEnMarcos then
            for nombreMarco, icono in pairs(iconosUnidad) do
                icono:Hide()
            end
            if resplandorLocal then resplandorLocal:Hide() end
            algunIconoEnMarcos = false
        end
        return
    end

    algunIconoEnMarcos = true
    RepasarUnidad("PlayerFrame", "player")
    RepasarUnidad("TargetFrame", "target")

    for i = 1, 4 do
        RepasarUnidad("PartyMemberFrame" .. i, "party" .. i)
    end

    for i = 1, 40 do
        local nombreMarco = "RaidGroupButton" .. i
        if getglobal(nombreMarco) then
            RepasarUnidad(nombreMarco, "raid" .. i)
        end
    end
end

----------------------------------------------------------------------------
--  Ventana de Emparejamiento WebRTC (/voz)
----------------------------------------------------------------------------
local ventanaEnlace

local function CrearVentanaEnlace()
    if ventanaEnlace then return ventanaEnlace end

    local f = CreateFrame("Frame", "ProjectJaina_VoicePairingFrame", UIParent)
    f:SetSize(420, 260)
    f:SetPoint("CENTER", UIParent, "CENTER", 0, 50)
    f:SetBackdrop({
        bgFile = "Interface\\DialogFrame\\UI-DialogBox-Background-Dark",
        edgeFile = "Interface\\DialogFrame\\UI-DialogBox-Border",
        tile = true, tileSize = 32, edgeSize = 32,
        insets = { left = 11, right = 12, top = 12, bottom = 11 }
    })
    f:EnableMouse(true)
    f:SetMovable(true)
    f:RegisterForDrag("LeftButton")
    f:SetScript("OnDragStart", f.StartMoving)
    f:SetScript("OnDragStop", f.StopMovingOrSizing)
    f:SetFrameStrata("DIALOG")
    table.insert(UISpecialFrames, "ProjectJaina_VoicePairingFrame")

    -- Encabezado
    local header = f:CreateTexture(nil, "ARTWORK")
    header:SetTexture("Interface\\DialogFrame\\UI-DialogBox-Header")
    header:SetWidth(300)
    header:SetHeight(64)
    header:SetPoint("TOP", f, "TOP", 0, 12)

    local title = f:CreateFontString(nil, "OVERLAY", "GameFontNormal")
    title:SetPoint("TOP", header, "TOP", 0, -14)
    title:SetText("|cff00ccffProject Jaina|r — Voz Espacial")

    -- Subtítulo
    local desc = f:CreateFontString(nil, "OVERLAY", "GameFontHighlightSmall")
    desc:SetPoint("TOP", f, "TOP", 0, -42)
    desc:SetWidth(380)
    desc:SetText("Comunícate en tiempo real con audio 3D por proximidad.\nAbre el enlace e ingresa tu código PIN de un solo uso:")

    -- Display de PIN
    local pinBox = f:CreateFontString("ProjectJaina_VoicePINText", "OVERLAY", "GameFontNormalHuge")
    pinBox:SetPoint("CENTER", f, "CENTER", 0, 18)
    pinBox:SetText("|cff00ff00------|r")
    pinBox:SetTextHeight(32)

    -- EditBox con URL
    local ebBg = CreateFrame("Frame", nil, f)
    ebBg:SetSize(340, 28)
    ebBg:SetPoint("CENTER", f, "CENTER", 0, -32)
    ebBg:SetBackdrop({
        bgFile = "Interface\\Tooltips\\UI-Tooltip-Background",
        edgeFile = "Interface\\Tooltips\\UI-Tooltip-Border",
        tile = true, tileSize = 16, edgeSize = 12,
        insets = { left = 3, right = 3, top = 3, bottom = 3 }
    })
    ebBg:SetBackdropColor(0, 0, 0, 0.8)

    local urlEdit = CreateFrame("EditBox", "ProjectJaina_VoiceURLEditBox", ebBg)
    urlEdit:SetAllPoints(ebBg)
    urlEdit:SetFontObject("GameFontHighlight")
    urlEdit:SetJustifyH("CENTER")
    urlEdit:SetAutoFocus(false)
    urlEdit:SetText("https://darckrovert.github.io/ProjectJaina_Voice/")
    urlEdit:SetScript("OnEditFocusGained", function(self) self:HighlightText() end)
    urlEdit:SetScript("OnEscapePressed", function(self) self:ClearFocus() end)

    -- Nota de cabinas
    local tip = f:CreateFontString(nil, "OVERLAY", "GameFontDisableSmall")
    tip:SetPoint("BOTTOM", f, "BOTTOM", 0, 52)
    tip:SetWidth(380)
    tip:SetText("|cffFFD100Tip de Cabina:|r Si tu PC no tiene micrófono, abre el link en tu celular con audífonos y habla como si estuvieras dentro del mundo.")

    -- Botón Cerrar
    local btnClose = CreateFrame("Button", nil, f, "UIPanelButtonTemplate")
    btnClose:SetSize(110, 26)
    btnClose:SetPoint("BOTTOM", f, "BOTTOM", 0, 18)
    btnClose:SetText("Cerrar")
    btnClose:SetScript("OnClick", function() f:Hide() end)

    f:Hide()
    ventanaEnlace = f
    return f
end

local function MostrarEnlace(pin, url)
    local v = CrearVentanaEnlace()
    local pinFont = getglobal("ProjectJaina_VoicePINText")
    local urlEdit = getglobal("ProjectJaina_VoiceURLEditBox")

    if pinFont then pinFont:SetText("|cff00ff00" .. tostring(pin or "ESPERANDO") .. "|r") end
    if urlEdit and url then urlEdit:SetText(url) end

    v:Show()
end

----------------------------------------------------------------------------
--  Recepción de Mensajes de Protocolo WP_VOICE
----------------------------------------------------------------------------
local function Procesar(mensaje)
    if not mensaje then return end

    -- Formato H:Nombre (Hablando)
    local _, _, accion, nombre = string.find(mensaje, "^(%a):(.+)$")
    if accion and nombre then
        if accion == "H" then
            hablando[nombre] = GetTime() + TIEMPO_VIDA
        elseif accion == "C" then
            hablando[nombre] = nil
        end
        return
    end

    -- Formato PIN:123456:Project Jaina Oficialvoz
    local _, _, pin, url = string.find(mensaje, "^PIN:(%d+):(.+)$")
    if pin then
        MostrarEnlace(pin, url)
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ccffProject Jaina Voz|r: Tu código de emparejamiento es |cff00ff00" .. pin .. "|r.")
        return
    end
end

----------------------------------------------------------------------------
--  Gestión de Placas de Nombre (Ambas Facciones)
----------------------------------------------------------------------------
local function EncenderPlacas(avisar)
    local ok1 = pcall(SetCVar, "nameplateShowFriends", 1)
    local ok2 = pcall(SetCVar, "nameplateShowEnemies", 1)

    pcall(function() if ShowNameplates then ShowNameplates() end end)
    pcall(function() if ShowFriendNameplates then ShowFriendNameplates() end end)

    if not (ok1 and ok2) and avisar then
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ccffProject Jaina Voz|r: Activa las placas de nombre con |cffFFFFFFV|r y |cffFFFFFFMayus+V|r.")
    end
end

local function AplicarAjustes(avisar)
    ProjectJaina_Voice_Settings = ProjectJaina_Voice_Settings or ProjectJainaVozAjustes or {}
    ProjectJainaVozAjustes = ProjectJaina_Voice_Settings
    if ProjectJainaVozAjustes.yaEncendidasUnaVez then return end

    if ProjectJainaVozAjustes.placas == nil then
        ProjectJainaVozAjustes.placas = true
    end

    if ProjectJainaVozAjustes.placas then
        EncenderPlacas(avisar)
        if avisar then
            DEFAULT_CHAT_FRAME:AddMessage("|cff00ccffProject Jaina Voz|r: Placas de nombre activadas para visualizar quién habla en 3D.")
        end
    end
    ProjectJainaVozAjustes.yaEncendidasUnaVez = true
end

----------------------------------------------------------------------------
--  Bucle de Renderizado y Eventos
----------------------------------------------------------------------------
local motor = CreateFrame("Frame")
local acumulado = 0

motor:SetScript("OnUpdate", function(self, elapsed)
    acumulado = acumulado + (elapsed or arg1 or 0.1)
    if acumulado < REFRESCO then return end
    acumulado = 0
    RepasarPlacas()
    RepasarMarcos()
end)

motor:RegisterEvent("CHAT_MSG_ADDON")
motor:RegisterEvent("PLAYER_ENTERING_WORLD")
motor:RegisterEvent("ADDON_LOADED")

motor:SetScript("OnEvent", function(self, evento, a1, a2, ...)
    local ev = evento or event
    local arg1 = a1 or arg1
    local arg2 = a2 or arg2

    if ev == "ADDON_LOADED" then
        if arg1 == ADDON_NAME or arg1 == "ProjectJaina_Voice" then
            AplicarAjustes(true)
        end
    elseif ev == "CHAT_MSG_ADDON" then
        if arg1 == PREFIJO then
            Procesar(arg2)
        end
    elseif ev == "PLAYER_ENTERING_WORLD" then
        hablando = {}
    end
end)

----------------------------------------------------------------------------
--  Comandos de Barra (/voz y /wpvoz)
----------------------------------------------------------------------------
local function ManejarComando(argumento)
    local arg = string.lower(argumento or "")

    if arg == "placas" then
        ProjectJaina_Voice_Settings = ProjectJaina_Voice_Settings or ProjectJainaVozAjustes or {}
    ProjectJainaVozAjustes = ProjectJaina_Voice_Settings
        ProjectJainaVozAjustes.placas = not ProjectJainaVozAjustes.placas
        if ProjectJainaVozAjustes.placas then
            EncenderPlacas(true)
            DEFAULT_CHAT_FRAME:AddMessage("|cff00ccffProject Jaina Voz|r: Placas de nombre |cff00ff00activadas|r.")
        else
            pcall(SetCVar, "nameplateShowFriends", 0)
            pcall(SetCVar, "nameplateShowEnemies", 0)
            DEFAULT_CHAT_FRAME:AddMessage("|cff00ccffProject Jaina Voz|r: Placas de nombre |cffFF5555desactivadas|r.")
        end
        return
    end

    if arg == "test" or arg == "yo" then
        local myName = UnitName("player")
        if myName then
            hablando[myName] = GetTime() + 5
            DEFAULT_CHAT_FRAME:AddMessage("|cff00ccffProject Jaina Voz|r: Probando altavoz en tu personaje durante 5 segundos.")
        end
        return
    end

    if arg == "off" then
        hablando = {}
        DEFAULT_CHAT_FRAME:AddMessage("|cff00ccffProject Jaina Voz|r: Todos los indicadores de voz apagados.")
        return
    end

    -- Por defecto: Solicita PIN al servidor y abre ventana
    local playerName = UnitName("player")
    if playerName then
        SendAddonMessage(PREFIJO, "GET_PIN", "WHISPER", playerName)
    end
    MostrarEnlace("SOLICITANDO...", "https://darckrovert.github.io/ProjectJaina_Voice/")
end

SLASH_WANOSVOZ1 = "/voz"
SLASH_WANOSVOZ2 = "/wanosvoz"
SLASH_WANOSVOZ3 = "/wpvoz"
SlashCmdList["WANOSVOZ"] = ManejarComando

DEFAULT_CHAT_FRAME:AddMessage("|cff00ccffProject Jaina Voz|r v" .. VERSION .. " cargado. Escribe |cffFFFFFF/voz|r para conectarte.")
