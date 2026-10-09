# 📜 Aviso Legal y Atribución — Wanos_Voice

Este proyecto incorpora código, conceptos arquitectónicos y recursos de la comunidad de desarrollo de World of Warcraft:

---

## 1. Arquitectura Base y Detección de Placas 3D
- **Proyecto Origen:** PeruLand Voz
- **Autoría Base:** Equipo de Desarrollo de PeruLand
- **Aportes Asimilados:** Lógica de inspección por regiones de `WorldFrame` para detección anónima de Nameplates en 3.3.5a, resplandor en retratos y anclaje de texturas de altavoz sobre barras de vida.

---

## 2. Re-ingeniería, Hardening y Gobernanza (Project Jaina)
- **Mantenimiento y Adaptación:** DarckRovert & Project Jaina Engineering Team
- **Servidor y Ecosistema:** [Project Jaina — Project Jaina](https://projectjaina.com/)
- **Transformaciones Arquitectónicas Implementadas:**
  1. Estandarización de protocolos de red bajo el prefijo unificado `WP_VOICE`.
  2. Sustitución de dependencias de ejecutables externos por integración nativa con el microservicio **WebRTC Proximity Hub** de Project Jaina.
  3. Adición de la interfaz modal in-game para emparejamiento seguro mediante código PIN de un solo uso (`/voz`).
  4. Integración con el módulo de servidor Eluna [`65_VoiceProximitySync.lua`](file:///E:/AzerothCore/server/lua_scripts/65_VoiceProximitySync.lua).
  5. Cero taints y total compatibilidad con clientes WoW 3.3.5a limpios sin inyección de DLLs.
