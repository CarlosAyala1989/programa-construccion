  Reporte de Implementación de Casos de Uso
  Proyecto: Plataforma de Gobernanza Documental Inteligente

  Nota: El caso de uso CU-07 (Gestionar incidentes de escaneo) es el único que parece estar parcialmente implementado a nivel de código (is_paused en scanner.py) pero no expuesto
  completamente en la UI, por lo que se ha excluido de la lista de implementaciones completas.

  ---

  CU-01: Autenticar usuario
   * Entorno: Web (SaaS) y Desktop (Edge)
   * Descripción: Permite a los administradores iniciar sesión en el panel web y a los empleados acceder al cliente de escritorio. En la web se maneja vía JWT y en el escritorio se
     valida contra la base de datos remota para iniciar una sesión local.
   * Archivos Implicados:
     * Web: src/app/page.tsx (Frontend), src/lib/auth.ts (Configuración), src/app/api/auth/[...nextauth]/route.ts (Backend API).
     * Desktop: web/index.html y web/js/app.js (Frontend Eel), src/controller.py y src/database/sqlite_manager.py (Backend).
   * Funciones Clave: 
     * authorize (Web - auth.ts), handleSubmit (Web - page.tsx).
     * login (Desktop - controller.py), authenticate_user (Desktop - sqlite_manager.py).

  CU-02: Gestionar usuarios y accesos
   * Entorno: Web (SaaS)
   * Descripción: El administrador puede crear nuevas credenciales de empleados (política Zero Trust), asignarlos a espacios de trabajo, dar de baja usuarios lógicamente (Soft Delete)
     y forzar la rotación de sus contraseñas.
   * Archivos Implicados:
     * Web: src/app/dashboard/users/page.tsx (Frontend), src/app/api/users/route.ts, src/app/api/users/[id]/route.ts, src/app/api/users/[id]/reset-password/route.ts (Backend API).
   * Funciones Clave:
     * handleSubmit (Crear empleado), toggleUserStatus (Baja lógica), handleResetPassword (Frontend).
     * POST, PATCH en las rutas de la API utilizando prisma.user.create y prisma.user.update.

  CU-03: Configurar espacios de trabajo
   * Entorno: Web (SaaS)
   * Descripción: Permite crear y administrar los "Silos Lógicos" o espacios de trabajo. Se define el nombre, la ruta destino de sincronización (Local, Google Drive, Dropbox), tokens
     de acceso, la contraseña de cifrado por defecto y se asignan usuarios.
   * Archivos Implicados:
     * Web: src/app/dashboard/workspaces/page.tsx, src/components/DriveFolderBrowser.tsx (Frontend), src/app/api/workspaces/route.ts, src/app/api/workspaces/[id]/route.ts (Backend
       API).
   * Funciones Clave:
     * handleSubmit (Crear espacio), handleAssignSubmit (Vincular usuarios), handleDriveSelect (Frontend).
     * POST y PATCH utilizando prisma.workspace.create y prisma.workspace.update.

  CU-04: Configurar políticas documentales y reglas IA
   * Entorno: Web (SaaS)
   * Descripción: El administrador define las políticas de seguridad (Semánticas o Visuales) y contraseñas de reemplazo. También configura los campos obligatorios de nomenclatura que
     la IA debe buscar en los documentos.
   * Archivos Implicados:
     * Web: src/app/dashboard/policies/page.tsx, src/app/dashboard/config/page.tsx (Frontend), src/app/api/policies/route.ts, src/app/api/nomenclatures/route.ts (Backend API).
   * Funciones Clave:
     * handleSubmit en policies (Crea política), handleAddNomenclature en config (Crea regla IA).
     * POST en API utilizando prisma.securityPolicy.create y prisma.nomenclatureField.create.

  CU-05: Preparar sesión de digitalización
   * Entorno: Desktop (Edge)
   * Descripción: El operario elige a qué espacio de trabajo ingresará los documentos, lo que arranca el monitoreo automático de la "Watch Folder" (carpeta de vigilancia) y configura
     el entorno temporal seguro.
   * Archivos Implicados:
     * Desktop: web/index.html, web/js/app.js (Frontend), src/controller.py, src/database/sqlite_manager.py (Backend).
   * Funciones Clave:
     * handleStartSession, selectWorkspace (Frontend app.js).
     * select_workspace, start_session (controller.py), create_session (sqlite_manager.py).

  CU-06: Digitalizar documentos físicos
   * Entorno: Desktop (Edge)
   * Descripción: Interoperabilidad de hardware para escanear usando impresoras físicas (vía SANE en Linux o WIA en Windows), además de importar archivos digitalizados previamente a la
     zona segura.
   * Archivos Implicados:
     * Desktop: web/index.html (Modal UI), web/js/app.js (Frontend), src/hardware/scanner.py (Lógica de Hardware), src/controller.py (Backend).
   * Funciones Clave:
     * executeScan, handleImportFiles (Frontend app.js).
     * scan_physical_document, import_files, start_watching, _on_new_file (scanner.py), scan_document (controller.py).

  CU-08: Clasificar documento mediante IA local
   * Entorno: Desktop (Edge)
   * Descripción: Ejecución de Inteligencia Local (PyTesseract para OCR / PyPDF2) en el lado del cliente para extraer el texto, encontrar la nomenclatura configurada por el admin, y
     estructurar/renombrar automáticamente el archivo resultante.
   * Archivos Implicados:
     * Desktop: src/core/ocr_engine.py (Motor IA), src/core/file_structurer.py (Manejo de rutas), src/controller.py (Orquestación).
   * Funciones Clave:
     * extract_text_from_pdf, extract_text_from_image, extract_nomenclature (ocr_engine.py).
     * RenameAndStructure (file_structurer.py).
     * _process_single_document [Fase 2] (controller.py).

  CU-09: Gestionar bandeja de pendientes
   * Entorno: Desktop (Edge)
   * Descripción: Manejo de excepciones. Si la IA no logra extraer la nomenclatura (por mala calidad de escaneo o formato ilegible), aísla el documento en una "Bandeja de Pendientes"
     para que el operario lo corrija manualmente desde la interfaz.
   * Archivos Implicados:
     * Desktop: web/correction.html y web/js/app.js (Frontend), src/core/pending_tray.py (Manejador de archivos), src/controller.py (Backend).
   * Funciones Clave:
     * handleCorrection (Frontend correction.html).
     * HandleOCRFailure (pending_tray.py).
     * get_pending_review, correct_document (controller.py).

  CU-10: Aplicar protección criptográfica
   * Entorno: Desktop (Edge)
   * Descripción: Ejecución del "Escudo de Privacidad". Verifica las políticas usando Visión por Computadora (OpenCV para sellos/marcas) o Semántica (texto), resuelve la prioridad de
     contraseñas, y cifra nativamente el PDF con AES. También aplica cifrado AES en reposo temporal a los archivos no procesados aún.
   * Archivos Implicados:
     * Desktop: src/core/crypto_engine.py (Criptografía), src/core/vision_engine.py (IA Visual OpenCV), src/core/secure_file_writer.py (Escritura temporal cifrada), src/controller.py
       (Backend).
   * Funciones Clave:
     * check_visual_policies, check_document (vision_engine.py).
     * resolve_password, encrypt_pdf (crypto_engine.py).
     * write_secure, read_secure (secure_file_writer.py).

  CU-11: Sincronizar documentos con la nube
   * Entorno: Desktop (Edge)
   * Descripción: Una vez finalizada la sesión, comprime automáticamente los archivos pesados (si así se configuró) y emplea un patrón Strategy para empujar los documentos cifrados al
     destino final en la nube (ej. Google Drive) usando las credenciales SaaS.
   * Archivos Implicados:
     * Desktop: src/sync/cloud_uploader.py (Motor de subida), src/sync/saas_api.py (Comunicación web), src/controller.py (Backend).
   * Funciones Clave:
     * upload, _upload_gdrive, compress_pdf, should_compress (cloud_uploader.py).
     * end_session, _process_all_pending (controller.py).

  CU-12: Auditar trazabilidad y reportes
   * Entorno: Web (SaaS) y Desktop (Edge)
   * Descripción: Sistema forense integral que registra absolutamente cada acción (procesamientos, logueos, cambios de política, errores de sincronización). El cliente local guarda
     eventos y hace push a la web. En la web se pueden visualizar, buscar y exportar a CSV.
   * Archivos Implicados:
     * Web: src/app/dashboard/logs/page.tsx (Frontend), src/app/api/logs/route.ts, src/app/api/logs/export/route.ts (Backend API).
     * Desktop: src/database/sqlite_manager.py (Almacén local), src/sync/saas_api.py (Backend).
   * Funciones Clave:
     * fetchLogs, handleExport (Frontend logs/page.tsx).
     * create_audit_log, sync_pending_logs (sqlite_manager.py).
     * sync_logs (saas_api.py).
