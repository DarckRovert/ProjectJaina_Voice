# 📋 Registro de Cambios — ProjectJaina_Voice

Todos los cambios notables de este proyecto están documentados en este archivo siguiendo el estándar [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/).

---

## [1.0.2] — 2026-10-24
### Corrección de Texturas, Registro de Prefijo y Anclas de Unidad
- **Textura de Indicador de Habla (`ProjectJaina_Voice.lua`):** Resuelto problema de dimensiones 0x0 en el resplandor de `PlayerFrame` asegurando dimensiones explícitas y anclas consistentes.
- **Registro de Prefijo de Red:** Invocación explícita de `RegisterAddonMessagePrefix` para `JAINA_VOICE` y `WP_VOICE` garantizando recepción fiable de paquetes de audio espacial en 3.3.5a.
- **Marcos de Grupo y Foco:** Reemplazados identificadores inexistentes `RaidGroupButton1..40` por hooks dinámicos a marcos de banda disponibles y añadido soporte nativo para `FocusFrame`.

---

## [1.0.1] — 2026-10-10
### Estabilización de Ecosistema y Gobernanza Oficial (Project Jaina)
- **Normalización de UI y Gráficos:** Incorporación de servidores STUN públicos en la topología WebRTC, reducción de latencia de sondeo de coordenadas y aislamiento de excepciones de socket.
- **Homologación Documental:** Incorporación y actualización formal de `GOVERNANCE.md`, `LICENSE`, `NOTICE.md` y `SECURITY.md`.
- **Licencia Canónica:** Consolidación de licencia MIT 2026 bajo titularidad de DarckRovert & Project Jaina Team.
- **Validación de Runtime:** Verificado al 100% con compilador sintáctico `lua52_compiler.exe -p` con 0 errores y 0 warnings.

---

## [1.0.0] — 2026-10-04
### Lanzamiento Inicial — Ecosistema Project Jaina WotLK 3.3.5a
- Implementación de la arquitectura base para Project Jaina Spatial Voice.
- Registro de comandos slash: `/voice, /pjvoice`.
- Persistencia de configuración en `ProjectJaina_VoiceDB`.
- Compatibilidad certificada con cliente WotLK 3.3.5a (Build 12340) y directiva `Interface: 30300`.
