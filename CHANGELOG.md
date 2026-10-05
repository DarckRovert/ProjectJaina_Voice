# Changelog - WoWPeru_Voice

Todas las modificaciones notables a este proyecto serán documentadas en este archivo.

El formato se basa en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/)
y este proyecto se adhiere a [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.0] - 2026-10-05

### Added
- **Arquitectura de Voz Espacial de Proximidad 3D:** Integración completa entre el cliente de juego (Addon), el servidor Eluna y el microservicio WebRTC SFU.
- **Addon de Cliente Oficial (`WoWPeru_Voice`):**
  - Protocolo ligero de comunicación sobre Addon Messages con prefijo canónico `WP_VOICE`.
  - Detección reactiva de actividad de voz (`H:Nombre` y `C:Nombre`) con altavoces visuales 3D sobre Nameplates y marcos de unidades Blizzard (`PlayerFrame`, `TargetFrame`, `PartyMemberFrame`, `RaidGroupButton`).
  - Comando `/voz` y `/wpvoz` para generar el PIN de emparejamiento web y toggle de nameplates.
  - Temporizador de seguridad con autocaducidad a 2.5 segundos para evitar iconos de altavoz fantasma ante desconexiones.
- **Módulo de Servidor Eluna (`65_VoiceProximitySync.lua`):**
  - Watchdog timer de 3 segundos para reciclaje seguro de sockets HTTP ante caídas del pipeline.
  - Telemetría asíncrona no bloqueante de coordenadas cada 250 ms (4 Hz) despachada al Coordinador.
- **Backend Coordinador WebRTC (`voice_service`):**
  - Spatial Hash Grid en O(1) con celdas de 50x50 metros para filtrado de proximidad acústica.
  - Panner 3D con modelo binaural HRTF en Web Audio API para auriculares y sonido estéreo inmersivo.
- **Documentación y Gobernanza:**
  - `README.md`, `LICENSE` (MIT), `NOTICE.md`, `CHANGELOG.md`, `.gitignore`, `.gitattributes` y registro unificado en `ECOSYSTEM_REGISTRY.md`.
