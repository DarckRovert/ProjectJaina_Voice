# 🌐 Registro de Ecosistema — WoWPeru_Voice

Ficha técnica oficial de registro en la infraestructura multi-addon de **WoW Perú - Reino Andino**.

---

## 1. Identidad del Addon en el Ecosistema

| Campo | Valor |
|---|---|
| **Nombre Técnico** | `WoWPeru_Voice` |
| **Carpeta Local** | `WoWPeru_Voice` |
| **Versión Actual** | `1.0.0` |
| **Clasificación** | Cliente / Audio & Proximidad |
| **Licencia Formal** | MIT |
| **Repositorio GitHub** | [WoWPeru_Voice](https://github.com/DarckRovert/WoWPeru_Voice) |
| **Entorno de Juego** | World of Warcraft 3.3.5a (Build 12340) / AzerothCore |

---

## 2. Red y Mensajería de Addon

| Propiedad | Valor |
|---|---|
| **Prefijo Oficial** | `WP_VOICE` |
| **Canales de Red** | `WHISPER` (a sí mismo / servidor) |
| **OpCodes Manejados** | `GET_PIN`, `PIN:code:url`, `H:name` (Hablando), `C:name` (Silenciado) |
| **Presupuesto Máximo** | < 80 bytes (Ultra ligero, cadencia de 2.5s) |
| **Transporte Seguro** | Auto-caducidad local para evitar indicadores bloqueados |

---

## 3. Persistencia de Datos

| Variable Global | Tipo | Ámbito | Propósito |
|---|---|---|---|
| `WoWPeruVozAjustes` | Tabla Lua (`SavedVariablesPerCharacter`) | Por Personaje | Guarda preferencias de visualización de placas |

---

## 4. Matriz de Integración del Ecosistema

| Sistema Coexistente | Modo de Interacción | Flujo de Datos |
|---|---|---|
| **`WoWPeru_Companion`** | Telemetría / Detección Social | Registrado en lista de presencia social de addons activos |
| **`AzerothCore (Eluna)`** | Cliente - Servidor Autoritativo | Backend `65_VoiceProximitySync.lua` vía telemetría asíncrona |
| **`WebRTC Proximity Hub`** | Puente Web / Móvil | Señalización y paneo espacial 3D en `wow-peru.lat/voz` |
| **`Nameplates 3D`** | Renderizado No Invasivo | Detección anónima de barras de vida y anclaje de altavoces |

---

## 5. Garantías de Rendimiento

- **Tiempo de Cuadro:** < 0.01 ms por fotograma (escaneo eficiente de WorldFrame a 10 Hz).
- **Consumo de Memoria:** ~ 0.4 MB (extremadamente ligero).
- **Compatibilidad de Hardware:** 100% verificado para PCs de cabina con procesadores Dual-Core y gráficos integrados Intel HD.

---

## 🏛️ Directorio Maestro del Ecosistema WoW Perú (18 Repositorios)

### A. Módulos Oficiales del Cliente (`Client\Interface\AddOns\`)

| # | Repositorio GitHub | Carpeta Local | Versión | Tipo / Licencia | Propósito en el Ecosistema |
|:---:|---|---|:---:|:---:|---|
| 01 | [WoWPeru_AbbreviatedStatus](https://github.com/DarckRovert/WoWPeru_AbbreviatedStatus) | `AbbreviatedStatus` | 1.2.1 | MIT / Fork | Abreviación compacta y formateo legible de salud y maná sin división por cero. |
| 02 | [WoWPeru_BattlePass](https://github.com/DarckRovert/WoWPeru_BattlePass) | `WoWPeru_BattlePass` | 2.0.0 | MIT | Pase de Batalla estacional de 50 niveles con backend Eluna y bitmask de progreso. |
| 03 | [WoWPeru_Carbonite](https://github.com/DarckRovert/WoWPeru_Carbonite) | `WoWPeru_Carbonite` | 3.3.4-WP | Other / EULA | Suite satelital HD de cartografía, navegación multi-zona y misiones. |
| 04 | [WoWPeru_Companion](https://github.com/DarckRovert/WoWPeru_Companion) | `WoWPeru_Companion` | 1.0.3 | MIT | Hub social ligero, cross-faction (/comerciar, /invitar) y telemetría de grupo. |
| 05 | [WoWPeru_DragonflightUI](https://github.com/DarckRovert/WoWPeru_DragonflightUI) | `cDF` | 1.0.0 | MIT / BSD | Re-implementación visual moderna estilo Dragonflight 10.x para cliente 3.3.5a. |
| 06 | [WoWPeru_GameModes](https://github.com/DarckRovert/WoWPeru_GameModes) | `WoWPeru_GameModes` | 1.0.0 | MIT | Selector cinemático de modos (Normal, Hardcore, Ironman) con verificación Eluna. |
| 07 | [WoWPeru_GMGenie](https://github.com/DarckRovert/WoWPeru_GMGenie) | `GMGenie` | 1.3.1 | GPL-3.0 | Suite administrativa integral para Game Masters adaptada a AzerothCore. |
| 08 | [WoWPeru_IntiObjGPS](https://github.com/DarckRovert/WoWPeru_IntiObjGPS) | `IntiObjGPS` | 1.0.0 | MIT | Editor por lotes de coordenadas GPS de GameObjects para Staff y constructores. |
| 09 | [WoWPeru_LoreHUD](https://github.com/DarckRovert/WoWPeru_LoreHUD) | `WoWPeru_LoreHUD` | 1.0.0 | MIT | Diálogos cinemáticos inmersivos y subtítulos estilizados para misiones y Lore. |
| 10 | [WoWPeru_PrideTrace](https://github.com/DarckRovert/WoWPeru_PrideTrace) | `WoWPeru_PrideTrace` | 1.0.0 | MIT | Rastreador de combate y telemetría de eventos de orgullo en tiempo real. |
| 11 | [WoWPeru_RaidSuite](https://github.com/DarckRovert/WoWPeru_RaidSuite) | `WoWPeru_RaidSuite` | 1.0.0 | MIT | Suite modular de herramientas analíticas para líderes de banda y oficiales. |
| 12 | [WoWPeru_Talented](https://github.com/DarckRovert/WoWPeru_Talented) | `Talented` | 3.3.5-WP | GPL-2.0 | Árbol de talentos avanzado con soporte para plantillas y compartición. |
| 13 | [WoWPeru_TBCBalance](https://github.com/DarckRovert/WoWPeru_TBCBalance) | `WoWPeru_TBCBalance` | 1.0.0 | MIT | Visualizador y calculadora de rebalanceo dinámico de clases TBC/WotLK. |
| 14 | [WoWPeru_Wardrobe](https://github.com/DarckRovert/WoWPeru_Wardrobe) | `WoWPeru_Wardrobe` | 1.0.0 | MIT | Catálogo de apariencias y transfiguración 3D escalonada sin freezes. |
| 15 | [WowPeruVisualShop](https://github.com/DarckRovert/WowPeruVisualShop) | `WowPeruVisualShop` | 1.0.0 | MIT | Tienda visual in-game de monturas, auras e indumentaria sin taints. |
| 16 | [WoWPeru_Voice](https://github.com/DarckRovert/WoWPeru_Voice) | `WoWPeru_Voice` | 1.0.0 | MIT | Sistema de voz espacial 3D y proximidad WebRTC sincronizado con Eluna. |

### B. Suites Comunitarias de Alto Rendimiento (`WoW_Peru_Lab\AddOns\`)

| # | Repositorio GitHub | Carpeta Local | Versión | Tipo / Licencia | Propósito en el Ecosistema |
|:---:|---|---|:---:|:---:|---|
| 17 | [WoWPeru_DBM](https://github.com/DarckRovert/WoWPeru_DBM) | `DBM-Core` (Monorepo) | 3.3.5-WP | GPL-2.0 | Alertas tácticas de jefes de banda y mazmorras con sincronización de timers. |
| 18 | [WoWPeru_GearScore](https://github.com/DarckRovert/WoWPeru_GearScore) | `GearScoreLite` (Monorepo) | 3.3.5-WP | GPL-3.0 | Evaluación instantánea de nivel de equipamiento sin saturar memoria ni CPU. |

---

## 🔒 Estándar de Excelencia y Convivencia Arquitectónica

1. **Cero Secuestro de Errores Globales:** Prohibido el uso de `seterrorhandler` invasivo.
2. **Inmunidad a Taint de Blizzard:** `UnitPopupMenus` y funciones protegidas de FrameXML permanecen vírgenes.
3. **Canales de Addon Seguros:** Todo intercambio cliente-servidor se canaliza por `WHISPER` a sí mismo (Tipo 7).
4. **Resiliencia en Cabinas de Internet:** Optimizado para bajo consumo de memoria, almacenamiento volátil y cero congelamientos de FPS.
