# Changelog - WoWPeru_Voice

Todas las modificaciones notables a este proyecto serán documentadas en este archivo.

El formato se basa en [Keep a Changelog](https://keepachangelog.com/es-ES/1.0.0/)
y este proyecto se adhiere a [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

---

## [1.0.1] - 2026-10-05

### Fixed & Optimized
- **Nameplate Scanning O(1) & Churn Elimination:**
  - Sustituida la asignación de tablas temporales `{ WorldFrame:GetChildren() }` en cada tick por `select(i, WorldFrame:GetChildren())` usando `GetNumChildren()`, eliminando picos de garbage collection (GC lag) en aglomeraciones de personajes.
  - Implementado caché local de referencias en marcos (`_wpVoiceIsPlate` y `_wpVoiceNameText`), evitando re-inspección repetitiva de regiones.
  - Detección universal de texto en placas de nombre mediante búsqueda dinámica de `FontString`, resolviendo incompatibilidad con nameplates de layouts no estándar (índices distintos de 7).
- **Control de Eventos y Timers en Cliente:**
  - Firmas de funciones `OnUpdate` (`self, elapsed`) y `OnEvent` (`self, event, arg1, arg2`) corregidas con fallbacks defensivos para compatibilidad total con el motor Blizzard 3.3.5a.
- **Transición Bidireccional de Habla y Silencio en Servidor (`65_VoiceProximitySync.lua`):**
  - Implementado cálculo de diferencias en `activeSpeakers` para emitir el evento `C:Nombre` de inmediato cuando un jugador deja de hablar, logrando apagado instantáneo de altavoces sin esperar el TTL de seguridad.
  - Limpieza de oradores al desconectarse del mundo mediante `RegisterPlayerEvent(4)`.
- **Resiliencia WebRTC en Backend y Frontend:**
  - Buffer de ICE candidates asíncronos en `app.js` para evitar rechazos previos a `setRemoteDescription`.
  - Fallback a `127.0.0.1` en el parsing de URL para WebSocket en `server.js` y comparación estricta de GUIDs.

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
