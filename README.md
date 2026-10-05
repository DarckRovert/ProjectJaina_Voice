# 🇵🇪 WoW Perú — Voz Espacial 3D & Proximidad (v1.0.0)

**Versión:** 1.0.0 (WotLK 3.3.5a WebRTC Proximity Edition)  
**Autor:** DarckRovert & WoW Perú Team  
**Servidor Destino:** [WoW Perú](https://wow-peru.lat/) — Reino Andino  
**Entorno de Ejecución:** World of Warcraft 3.3.5a (Build 12340) | Lua 5.1 / Eluna C++  
**Repositorio Oficial:** [DarckRovert/WoWPeru_Voice](https://github.com/DarckRovert/WoWPeru_Voice)

---

[![WoW Client](https://img.shields.io/badge/WoW%20Client-3.3.5a%20(Build%2012340)-blue.svg)](https://wow-peru.lat/)
[![Servidor](https://img.shields.io/badge/Servidor-WoW%20Perú-gold.svg)](https://wow-peru.lat/)
[![Version](https://img.shields.io/badge/version-1.0.0-brightgreen.svg)](https://github.com/DarckRovert/WoWPeru_Voice/releases)
[![Build Status](https://img.shields.io/badge/CI-Passing-success.svg)](https://github.com/DarckRovert/WoWPeru_Voice/actions)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## 🌟 ¿Qué es WoWPeru_Voice?

**WoWPeru_Voice** es el **módulo oficial #16** del ecosistema de addons de **WoW Perú - Reino Andino**. Proporciona una interfaz visual de alta fidelidad para la comunicación de voz espacial 3D y por proximidad dentro del cliente World of Warcraft 3.3.5a (Wrath of the Lich King), sincronizada con el backend **WebRTC Proximity Hub** de WoW Perú.

```
┌────────────────────────────────────────────────────────────────────────┐
│               ARQUITECTURA DE VOZ ESPACIAL WOW PERÚ                    │
├────────────────────────┬──────────────────────┬────────────────────────┤
│ 🔊 PLACAS Y RETRATOS   │ 🔗 VINCULACIÓN /VOZ  │ 🌐 WEBRTC BINAURAL     │
│ Altavoces sobre placas │ Ventana modal con    │ Web Audio API con HRTF │
│ 3D de ambas facciones  │ PIN de emparejamiento│ en navegador de PC o   │
│ y Player/Target/Party. │ y URL de sesión web. │ celular (cabina-ready).│
└────────────────────────┴──────────────────────┴────────────────────────┘
```

---

## 🚀 Funcionalidades Principales

### 1. 🔊 Detección y Renderizado Visual en Tiempo Real
- **Placas de Nombre 3D (Nameplates):** Detecta dinámicamente las barras de vida en el espacio tridimensional y coloca un icono de altavoz animado sobre la cabeza del personaje que está hablando.
- **Marcos de Unidad (UnitFrames):** Enciende el altavoz en los retratos de `PlayerFrame`, `TargetFrame`, `PartyMemberFrame1..4` y marcos de banda `RaidGroupButton1..40`.
- **Aura Resplandeciente:** Resalta tu propio avatar (`PlayerPortrait`) con un halo verde cuando tu micrófono está activo.
- **Autocaducidad Resiliente:** Si se pierde la señal de habla, el altavoz se desvanece automáticamente a los 2.5 segundos para evitar indicadores atascados.

### 2. 🔗 Conexión Instantánea con PIN (`/voz`)
- Al escribir `/voz`, el addon solicita al servidor Eluna un PIN temporal de 6 dígitos.
- Despliega una ventana modal con el enlace web oficial (`https://wow-peru.lat/voz`) y el PIN resaltado.
- **Apto para Cabinas de Internet:** Permite abrir el enlace en un smartphone con audífonos, resolviendo el problema de PCs sin micrófono.

### 3. 🛡️ Inmunidad a Taint & Cero Falsos Positivos
- No modifica `Wow.exe` ni inyecta DLLs peligrosas que disparen bloqueos de Windows Defender o Deep Freeze.
- Todo el procesamiento de audio espacial se realiza mediante WebRTC y Web Audio API (HRTF) fuera del proceso del juego.

---

## 💻 Comandos de Barra (Slash Commands)

| Comando | Acción |
|---|---|
| `/voz` o `/wpvoz` | Solicita un código PIN al servidor y abre la ventana de vinculación web. |
| `/wpvoz placas` | Activa o desactiva la visualización de altavoces sobre placas de nombre. |
| `/wpvoz yo` o `/wpvoz test` | Prueba el altavoz y resplandor en tu personaje durante 5 segundos. |
| `/wpvoz off` | Apaga inmediatamente todos los indicadores de voz activos. |

---

## 📦 Instalación

1. Descarga o clona este repositorio:
   ```bash
   git clone https://github.com/DarckRovert/WoWPeru_Voice.git
   ```
2. Mueve la carpeta a tu directorio de juego:
   ```
   World of Warcraft/Interface/AddOns/WoWPeru_Voice/
   ```
3. Verifica que la ruta contenga directamente:
   - `WoWPeru_Voice.toc`
   - `WoWPeru_Voice.lua`

---

## ⚖️ Licencia

Distribuido bajo la **Licencia MIT**. Consulta [LICENSE](LICENSE) para más detalles.  
Copyright (c) 2026 DarckRovert & WoW Perú Team.
