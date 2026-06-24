# Reporte de Estado de Sprints: Plataforma DocuZen vs Código Fuente

Este documento contrasta la planificación del **Product Backlog (G01_Product_Backlog_DocuZen.pdf)** con el **código fuente actual** en los directorios `@construccion-web` y `@construccion-escritorio`. 

Se detalla qué requerimientos (RF y RNF) se han cumplido en cada uno de los 8 Sprints planificados, los archivos implicados y el estado de cumplimiento.

---

## 🟢 Sprint 1 (11/05/2026) — Fundación Zero Trust y Criptografía Base
**Estado General:** **COMPLETADO**

*   ✅ **RF-01: Creación de Perfiles de Usuario**
    *   *Implementación:* Se cumple a través del panel SaaS donde solo el `ADMIN` puede crear empleados (Zero Trust). No hay auto-registro.
    *   *Archivos:* `src/app/dashboard/users/page.tsx`, `src/app/api/users/route.ts` (Web).
*   ✅ **RF-03: Bloqueo de Interfaz Local**
    *   *Implementación:* El cliente Desktop bloquea las funciones de captura hasta que el usuario se loguea y selecciona un `Workspace` (Espacio de Trabajo) válido.
    *   *Archivos:* `web/js/app.js` (Función `handleStartSession`), `src/controller.py` (Desktop).
*   ✅ **RF-09: Aplicación de Contraseña Predeterminada**
    *   *Implementación:* Se aplica la contraseña `defaultPassword` del Workspace si no hay políticas IA superiores que la reemplacen.
    *   *Archivos:* `src/core/crypto_engine.py` (Desktop - Función `resolve_password`).
*   ✅ **RNF-11 y RNF-04**
    *   *Implementación:* Cliente empaquetable para Windows (Evidenciado en `build.spec` con PyInstaller) y confidencialidad en reposo local implementada con AES-256 GCM.

---

## 🟡 Sprint 2 (18/05/2026) — Ingesta Segura y Directorio Cifrado
**Estado General:** **PARCIALMENTE COMPLETADO (Con observaciones)**

*   ✅ **RF-04: Directorio Temporal Cifrado**
    *   *Implementación:* Todo archivo que entra al directorio temporal (`temp_workspace`) se cifra inmediatamente usando AES-256 en memoria antes de tocar el disco.
    *   *Archivos:* `src/core/secure_file_writer.py` (Desktop - Función `write_secure`).
*   ⚠️ **RF-05: Pausa por Atasco Mecánico**
    *   *Implementación:* A nivel de Backend (Python) existe la lógica (`is_paused`, `memory_queue` en `scanner.py`), sin embargo, **falta implementarlo en la UI (Eel/JS)** para que el operador pueda visualizar la alerta y presionar un botón de "Reanudar" el escaneo de los folios en memoria.
*   ✅ **RNF-09: Interoperabilidad de Captura de Hardware**
    *   *Implementación:* Lógica de escaneo nativo usando SANE (Linux) y WIA (Windows).
    *   *Archivos:* `src/hardware/scanner.py` (Desktop - Función `scan_physical_document`).

---

## 🟢 Sprint 3 (25/05/2026) — Motor OCR y Clasificación Inteligente
**Estado General:** **COMPLETADO**

*   ✅ **RF-06: Procesamiento OCR y Extracción**
    *   *Implementación:* Uso de PyTesseract y PyPDF2 para extraer texto y buscar metadatos usando expresiones regulares y diccionarios del administrador.
    *   *Archivos:* `src/core/ocr_engine.py` (Desktop - Funciones `extract_text_from_pdf` y `extract_nomenclature`).
*   ✅ **RF-07: Renombrado y Estructuración de Carpetas**
    *   *Implementación:* El motor autoconstruye el path jerárquico según los metadatos encontrados.
    *   *Archivos:* `src/core/file_structurer.py` (Desktop - Función `RenameAndStructure`).
*   ✅ **RF-08: Derivación a Bandeja de Pendientes**
    *   *Implementación:* Si el OCR falla o no halla los metadatos obligatorios, el documento se enruta a `PENDING_REVIEW` y se habilita una ventana UI para corrección.
    *   *Archivos:* `src/core/pending_tray.py`, `src/controller.py`, `web/correction.html` (Desktop).

---

## 🟢 Sprint 4 (01/06/2026) — Escudo de Privacidad y Resolución Jerárquica
**Estado General:** **COMPLETADO**

*   ✅ **RF-10: Resolución Jerárquica de Reglas**
    *   *Implementación:* El motor de OpenCV (Plantillas visuales) tiene prioridad absoluta sobre las reglas semánticas (OCR) para aplicar la contraseña más restrictiva.
    *   *Archivos:* `src/core/crypto_engine.py` (Desktop - Función `resolve_password`), `src/core/vision_engine.py`.
*   ✅ **RF-11: Re-evaluación Obligatoria (Correcciones)**
    *   *Implementación:* Al corregir manualmente un documento desde la bandeja, la función obliga a pasar el archivo nuevamente por `_process_single_document` para aplicar el Escudo de Privacidad.
    *   *Archivos:* `src/controller.py` (Desktop - Función `correct_document`).
*   ✅ **RNF-06: No Repudio y Responsabilidad (Accountability)**
    *   *Implementación:* Logs locales configurados en esquema *append-only* en SQLite y posterior ingesta al SaaS.
    *   *Archivos:* `src/database/sqlite_manager.py` (Desktop), `prisma/schema.prisma` (Web).

---

## 🟢 Sprint 5 (08/06/2026) — Sincronización Cloud y Prevención de Colisiones
**Estado General:** **COMPLETADO**

*   ✅ **RF-13: Sincronización Automática**
    *   *Implementación:* Patrón Strategy implementado para subir vía APIs (Google Drive o destino Local) en segundo plano al cerrar la sesión.
    *   *Archivos:* `src/sync/cloud_uploader.py`, `src/controller.py` (Desktop).
*   ✅ **RF-14: Prevención de Colisiones de Archivos**
    *   *Implementación:* Sufijos secuenciales automáticos (`_v2`, `_v3`) añadidos si ya existe el nombre en disco/nube.
    *   *Archivos:* `src/sync/cloud_uploader.py` (Desktop - Función `_prevent_collision`).
*   ✅ **RF-15: Compresión PDF Opcional**
    *   *Implementación:* Reducción de tamaño sin pérdida de datos en caso de exceder un límite MB determinado por el SaaS usando PyPDF2.
    *   *Archivos:* `src/sync/cloud_uploader.py` (Desktop - Funciones `should_compress`, `compress_pdf`).

---

## 🟢 Sprint 6 (15/06/2026) — Resiliencia Offline y Continuidad del Negocio
**Estado General:** **COMPLETADO**

*   ✅ **RF-12: Encolado de Archivos Offline**
    *   *Implementación:* Uso de `local_queue.db` para persistir estado `PENDING_ENVIO` de forma offline y retomarlo.
    *   *Archivos:* `src/database/sqlite_manager.py` (Desktop).
*   ✅ **RF-16: Logs Cifrados Offline y RF-17: Sincronización de Logs**
    *   *Implementación:* Bitácora inmutable en SQLite local sincronizada masivamente cuando vuelve la red hacia el endpoint `/api/sync/logs`.
    *   *Archivos:* `src/database/sqlite_manager.py` (Desktop), `src/app/api/sync/logs/route.ts` (Web).

---

## 🔴 Sprint 7 (22/06/2026) — Gobernanza Avanzada y Actualización OTA
**Estado General:** **INCOMPLETO (Faltan módulos críticos)**

*   ✅ **RF-02: Desactivación Lógica de Cuenta**
    *   *Implementación:* Uso de campo `isActive` (Soft Delete) operado por el Administrador. No se borra el registro de la BD.
    *   *Archivos:* `src/app/api/users/[id]/route.ts` (Web).
*   ❌ **RNF-13: Modificabilidad y Despliegue No Invasivo (Actualización OTA del motor de IA)**
    *   *Diagnóstico:* **NO IMPLEMENTADO**. Revisando todo el código base, no existe ningún script, módulo (`OTAUpdateManager`), ni infraestructura en Node.js/Next.js o Python para empaquetar, versionar, o distribuir dinámicamente nuevos modelos `.weights` o binarios de la IA hacia los clientes locales en tiempo de ejecución. 

---

## 🟡 Sprint 8 (29/06/2026) — Integración Full-Stack, Rendimiento y Cierre
**Estado General:** **EN PROGRESO / PENDIENTE DE CIERRE**

*   **Diagnóstico de Integración:** La orquestación Full-Stack entre Next.js (Web) y Python/Eel (Desktop) existe y funciona muy bien a través de los endpoints de la API (`saas_api.py` y `cloud_uploader.py`). 
*   **Pendientes para el cierre formal:**
    1.  Completar el módulo OTA del Sprint 7.
    2.  Habilitar el botón de pausa y reanudación por atascos en el frontend `index.html` (Sprint 2).
    3.  Aprobar formalmente los tests UAT y de rendimiento en servidor de producción (esto recae en el equipo de QA humano).

---

### Resumen Ejecutivo
El proyecto tiene un nivel de madurez alto (estimado en un **85-90%** del Backlog). La lógica criptográfica, la IA local, el sincronizador y la interfaz web están listos. Sin embargo, para finalizar oficialmente, el equipo debe abordar la **Actualización Over-The-Air (OTA) de los motores de IA** y corregir la **interfaz para pausar atascos**.