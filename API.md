# 🔌 Especificación Técnica y API — Wanos_Voice

[![GitHub](https://img.shields.io/badge/GitHub-DarckRovert%2FWanos_Voice-black?logo=github)](https://github.com/DarckRovert/Wanos_Voice)
[![Ecosistema](https://img.shields.io/badge/Ecosistema-WoW%20Per%C3%BA%203.3.5a-gold.svg)](https://worldofwanos.com/)

## 📌 Resumen Arquitectónico
Sistema de comunicación por voz espacial 3D y proximidad en tiempo real basado en WebRTC para World of Warcraft 3.3.5a (Project Jaina). Calcula distancia euclidiana y ángulo tridimensional del emisor respecto al receptor.

- **Rol en el Ecosistema:** Módulo Oficial #17 — Audio Espacial & WebRTC
- **Archivo Principal TOC:** `Wanos_Voice.toc`
- **Compatibilidad del Motor:** World of Warcraft 3.3.5a (Build 12340)

---

## ⌨️ Comandos de Consola (Slash Commands)
- `/voz`: Acceso principal o comando del addon.
- `/wpvoz`: Acceso principal o comando del addon.

---

## 📡 Protocolo de Red y Eventos
- `WP_VOICE`: Prefijo registrado para sincronización de datos.
- `WP_VOICE_POS`: Prefijo registrado para sincronización de datos.

### Eventos del Motor 3.3.5a Gestionados
- `PLAYER_LOGIN` / `ADDON_LOADED`: Inicialización atómica de tablas de configuración y hooks.
- `PLAYER_ENTERING_WORLD`: Sincronización de estado tras transiciones de pantalla o mapa.
- `PLAYER_LOGOUT`: Guardado seguro en disco de las variables locales.

---

## 💾 Persistencia de Datos (SavedVariables)
- `WanosVozAjustes`: Almacenamiento estructurado de configuración y estado persistente.

---

## 🛠️ Buenas Prácticas de Integración
1. Toda invocación a funciones públicas debe verificar previamente la existencia del espacio de nombres en `_G`.
2. Las tablas de configuración deben consultarse en modo lectura sin sobreescribir valores por omisión no validados.
3. El intercambio de datos con otros addons debe efectuarse a través del bus oficial `Wanos_Companion` o hooks de eventos estándar.
