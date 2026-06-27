# Plan de cumplimiento legal peruano para la plataforma

Fecha de revision: 2026-06-24  
Alcance revisado: `construccion-web` (Next.js/Prisma/MySQL) y `construccion-escritorio` (Python/Eel/SQLite/MySQL/Google Drive).  
Skill usada: paquete local `compliance-pe` encontrado en `compliance-pe/`.

> Aviso obligatorio: este documento no constituye asesoria legal ni garantiza cumplimiento certificado. Es una revision tecnica y documental basada en evidencia del repositorio y fuentes oficiales peruanas. La validacion final debe realizarla el titular/responsable del tratamiento con asesor legal, especialmente por el tratamiento documental, OCR, nube y posibles datos sensibles.

## Veredicto ejecutivo

El programa **no cumple integralmente** con la normativa peruana aplicable. Tiene controles tecnicos valiosos, pero faltan piezas legales y operativas obligatorias o altamente recomendables: politica de privacidad, informacion previa al titular, matriz de bases legales, canal ARCO, inventario de bancos de datos, evaluacion de transferencias internacionales, contratos/garantias con encargados, documento de seguridad, plan de incidentes, reglas de retencion/supresion y expediente de revision legal.

El riesgo es **alto** porque la plataforma digitaliza y procesa documentos con OCR, guarda usuarios, credenciales, tokens de Google Drive, logs, rutas y archivos PDF que pueden contener datos personales comunes o sensibles. Debe tratarse como proyecto de **revision legal recomendada / alto riesgo practico** hasta que se limite formalmente el tipo de documentos admitidos.

## Fuentes oficiales consultadas

- Ley N. 29733, Ley de Proteccion de Datos Personales: https://www.gob.pe/institucion/congreso-de-la-republica/normas-legales/243470-29733
- D.S. N. 016-2024-JUS, Reglamento de la Ley N. 29733: https://www.gob.pe/institucion/smv/normas-legales/6426760-016-2024-jus
- R.D. N. 100-2025-JUS-DGTAIPD, Directiva del Oficial de Datos Personales: https://www.gob.pe/institucion/anpd/normas-legales/7574631-100-2025-jus-dgtaipd
- R.M. N. 476-2025-JUS/SG, metodologia de calculo de multas: https://www.gob.pe/institucion/anpd/normas-legales/7575999-476-2025-jus-sg
- Indecopi, Libro de Reclamaciones: https://consumidor.gob.pe/libro-de-reclamaciones/

Referencias normativas principales: Ley 29733 arts. 13, 15, 16, 17, 18, 19-24 y 34; Reglamento D.S. 016-2024-JUS arts. 2-10, 12-18, 31-36, 37-40, 42-48; Directiva ODP 2025; Codigo de Proteccion y Defensa del Consumidor Ley 29571 y Reglamento del Libro de Reclamaciones si el SaaS se ofrece a consumidores o clientes por web.

## Evidencia tecnica relevante

### Web

- Trata datos de usuarios: nombre, email, password, rol, estado, secreto TOTP y fecha de confirmacion en `construccion-web/prisma/schema.prisma:13`.
- Guarda tokens y credenciales de nube: `cloudRefreshToken`, `defaultPassword`, `SecurityPolicy.password` y `cloudCredentials` en `construccion-web/prisma/schema.prisma:31`, `construccion-web/prisma/schema.prisma:46` y `construccion-web/prisma/schema.prisma:90`.
- Tiene logs de auditoria, pero sin IP ni user-agent en el modelo `AuditLog` (`construccion-web/prisma/schema.prisma:77`).
- El login web recopila email, password, TOTP y reCAPTCHA sin link visible a politica de privacidad ni aviso de tratamiento (`construccion-web/src/app/page.tsx:66`).
- Hay bcrypt, reCAPTCHA y TOTP en `construccion-web/src/lib/auth.ts:23`, `construccion-web/src/lib/auth.ts:44` y `construccion-web/src/lib/auth.ts:52`.
- `POST /api/logs` permite crear logs sin autenticar (`construccion-web/src/app/api/logs/route.ts:61`).
- `api/sync/config`, `api/sync/logs` y `api/sync/upload` solo verifican que exista `Authorization: Bearer`, pero no validan el token contra una firma, usuario, scope o expiracion (`construccion-web/src/app/api/sync/config/route.ts:6`, `construccion-web/src/app/api/sync/logs/route.ts:5`, `construccion-web/src/app/api/sync/upload/route.ts:5`).
- `api/drive/folders` recibe access tokens en query/body y no exige sesion admin propia (`construccion-web/src/app/api/drive/folders/route.ts:3`); el componente los envia en URL (`construccion-web/src/components/DriveFolderBrowser.tsx:88`).
- El cifrado web de PDF usa Ghostscript con `-dKeyLength=128`, no AES-256 (`construccion-web/src/lib/pdf-server.ts:101`).
- El panel de politicas muestra contrasenas de cifrado en claro (`construccion-web/src/app/dashboard/policies/page.tsx:170`).
- `construccion-web/dev.db` y `construccion-web/prisma/dev.db` estan versionados en el repo interno de `construccion-web`; `prisma/dev.db` contiene al menos 1 usuario.

### Escritorio

- Lee credenciales MySQL desde `.env` y conecta directamente a la base central (`construccion-escritorio/src/database/sqlite_manager.py:52`, `construccion-escritorio/src/database/sqlite_manager.py:194`).
- Autentica usuarios contra MySQL con bcrypt y limita a `DESKTOP_SCANNER` (`construccion-escritorio/src/database/sqlite_manager.py:220`).
- SQLite local guarda cola, rutas, nombres originales, logs, sesiones y una columna `encryption_password` (`construccion-escritorio/src/database/sqlite_manager.py:122`).
- Cachea workspaces, policies y config localmente, incluyendo passwords/tokens segun datos recibidos de MySQL (`construccion-escritorio/src/database/sqlite_manager.py:273`, `construccion-escritorio/src/database/sqlite_manager.py:294`, `construccion-escritorio/src/database/sqlite_manager.py:319`).
- El archivo se descifra temporalmente a `file_path + ".clear"` para OCR/procesamiento (`construccion-escritorio/src/controller.py:425`).
- El cifrado PDF de escritorio declara AES-256, pero el comentario reconoce que PyPDF2 usa AES-128 por defecto (`construccion-escritorio/src/core/crypto_engine.py:40`).
- Los archivos runtime viven en `data`, `temp_workspace`, `processed`, `pending_review` y `cloud_output` (`construccion-escritorio/src/app_paths.py:41`).
- El instalador copia la conexion de base de datos de `construccion-web/.env` a `data\.env` en Windows (`construccion-escritorio/EMPAQUETADO_WINDOWS.md:24`).
- La UI de escritorio arma HTML con nombres/rutas desde datos dinamicos sin escape explicito en varias zonas (`construccion-escritorio/web/js/app.js:122`).

## Estado de cumplimiento por control

| Area | Estado | Brecha |
|---|---:|---|
| Aplicabilidad peruana | Parcial | Debe documentarse si la empresa opera en Peru, atiende titulares ubicados en Peru o procesa por cuenta de clientes peruanos. |
| Inventario de bancos y tratamientos | Brecha | No existe inventario ni preparacion para Registro Nacional de Proteccion de Datos Personales. |
| Informacion previa / politica de privacidad | Brecha | No hay politica ni aviso visible en login web/escritorio. |
| Consentimiento o base legal por finalidad | Brecha | No hay matriz de bases por cuenta, seguridad, OCR, nube, auditoria, soporte, Google/reCAPTCHA. |
| Derechos ARCO | Brecha | No existe correo, formulario, SLA, verificacion de identidad ni registro de solicitudes. |
| Seguridad | Parcial | Hay bcrypt, roles, 2FA y cifrado PDF, pero hay endpoints sin validacion real, secretos en claro, logs incompletos y cifrado PDF debil frente a lo declarado. |
| Documento de seguridad | Brecha | No existe documento aprobado con accesos, privilegios, ciclo de vida, inventario y sistemas. |
| Audit log | Parcial | Existen logs, pero sin IP/user-agent, con endpoints falsificables y sin politica de retencion/disposicion. |
| Incidentes | Brecha | No hay plan, registro, severidad, notificacion ANPD/titulares ni flujo 48h. |
| Transferencias internacionales/proveedores | Brecha | Google Drive, reCAPTCHA, Google OAuth, hosting/DB y posibles subencargados no estan inventariados ni contractualizados. |
| ODP | No verificable | Por volumen/sensibles puede aplicar; falta evaluacion formal. |
| EIPD | Recomendado/brecha | Por OCR, documentos arbitrarios, nube y potenciales sensibles se debe elaborar EIPD antes de produccion real. |
| Libro de Reclamaciones | Condicional | Si se vende el SaaS/servicio a consumidores o por plataforma web, falta Libro de Reclamaciones virtual, aviso y flujo de respuesta 15 dias habiles. |

## Plan de cambios para implementar despues

### P0 - Bloqueantes legales y de gobierno

1. Crear carpeta `.compliance/` con documentos base del paquete `compliance-pe`:
   - `lpdp-inventario-bancos-tratamientos.md`
   - `lpdp-politica-privacidad.md`
   - `lpdp-autorizacion-consentimiento.md`
   - `lpdp-canal-derechos-arco.md`
   - `lpdp-anexo-transferencias-internacionales.md`
   - `lpdp-documento-seguridad.md`
   - `lpdp-plan-respuesta-incidentes.md`
   - `lpdp-registro-incidentes.md`
   - `lpdp-eipd.md`
   - `lpdp-evaluacion-alto-riesgo-regulado.md`
   - `lpdp-plan-gates-produccion.md`
2. Definir datos de organizacion: razon social, RUC, domicilio, representante, correo de privacidad, telefono, sector y si se ofrece a consumidores o solo B2B interno.
3. Crear matriz de finalidades y bases legales:
   - cuenta de usuario y autenticacion;
   - seguridad, auditoria y antifraude;
   - digitalizacion, OCR, clasificacion y cifrado documental;
   - almacenamiento local y nube;
   - soporte, administracion y mantenimiento;
   - Google OAuth/reCAPTCHA;
   - retencion de logs y evidencia.
4. Definir bancos de datos personales y preparar inscripcion/actualizacion ante el Registro Nacional:
   - Usuarios y administradores;
   - Documentos digitalizados;
   - Auditoria y seguridad;
   - Proveedores/soporte;
   - Reclamos/ARCO, si aplica.
5. Clasificar proveedores y transferencias:
   - Google Drive/OAuth/reCAPTCHA;
   - proveedor de hosting y base MySQL;
   - Vercel u otro despliegue si se usa;
   - librerias/servicios de analitica si se agregan;
   - equipos de soporte o mantenimiento.
6. Elaborar decision ODP:
   - Si hay grandes volumenes, datos sensibles o el giro principal incluye tratamiento documental sensible, designar ODP, publicar contacto y comunicar a ANPD dentro del plazo aplicable.
   - Si no aplica, dejar justificacion versionada.
7. Elaborar EIPD antes de produccion real con documentos de clientes, porque el sistema acepta PDFs/imagenes arbitrarios y OCR puede revelar salud, RR.HH., financieros, legales, menores o datos sensibles.

### P1 - Web: cambios funcionales

1. Publicar rutas legales:
   - `/privacidad`
   - `/terminos`
   - `/arco`
   - `/incidentes-seguridad` o canal interno
   - `/libro-reclamaciones` si el producto se ofrece a consumidores o ventas web.
2. Enlazar politica de privacidad y aviso corto en:
   - login web (`src/app/page.tsx`);
   - pantalla de documentos web;
   - alta/edicion de usuarios;
   - conexion de Google Drive;
   - subida de documentos.
3. Agregar versionado de documentos legales:
   - tabla `LegalDocumentVersion`;
   - tabla `PrivacyNoticeAcknowledgement` o `ConsentRecord`;
   - timestamp, IP, user-agent, version aceptada, finalidad y fuente.
4. Implementar ARCO:
   - tabla `DataSubjectRequest`;
   - formulario o endpoint protegido;
   - verificacion de identidad;
   - estados, responsable, plazos, evidencias y exportacion;
   - funciones para acceso, rectificacion, supresion/cancelacion, oposicion y revocatoria cuando aplique.
5. Corregir autenticacion de APIs de escritorio:
   - eliminar o proteger `POST /api/logs`;
   - reemplazar el "Bearer solo presente" de `/api/sync/*` por JWT firmado o API keys por instalacion con scopes, expiracion y rotacion;
   - validar que el `userId` y `workspaceId` del payload coincidan con el token;
   - registrar IP/user-agent de la llamada.
6. Corregir integracion Google Drive:
   - exigir sesion admin en `/api/drive/folders`;
   - no enviar access tokens por query string;
   - usar POST server-side o guardar token solo en memoria del servidor durante OAuth;
   - limitar scopes y documentar transferencia internacional/encargo.
7. Cifrar secretos en reposo:
   - `Workspace.cloudRefreshToken`;
   - `Config.cloudCredentials`;
   - `SecurityPolicy.password`;
   - `User.twoFactorSecret`;
   - cualquier password default de workspace.
   Usar cifrado envelope AES-GCM con clave maestra fuera de la BD (`KMS`, secret manager o variable protegida), rotacion y no mostrar secretos completos en UI.
8. Ajustar UI de politicas:
   - no renderizar contrasenas en claro;
   - permitir crear/rotar/revocar, no leer;
   - mostrar solo alias/huella parcial.
9. Mejorar seguridad de login:
   - mensajes genericos para evitar enumeracion de usuarios;
   - rate limiting por IP/email;
   - bloqueo temporal;
   - 2FA obligatorio para administradores;
   - rotacion forzada de password inicial.
10. Completar audit log conforme al Reglamento:
   - actor, accion, entidad, workspace, resultado, IP, user-agent, fecha, antes/despues cuando aplique;
   - integridad/tamper evidence;
   - retencion minima de registros logicos por 2 anos y politica de disposicion.
11. Crear jobs de retencion:
   - purga de tokens revocados;
   - eliminacion o bloqueo de documentos locales/nube cuando proceda;
   - limpieza de temporales;
   - reglas distintas para logs, usuarios inactivos, documentos y solicitudes ARCO.
12. Revisar archivos versionados:
   - sacar `dev.db` y `prisma/dev.db` del repositorio si contienen datos reales;
   - mantener seeds anonimos;
   - agregar regla explicita `*.db` en `construccion-web/.gitignore`.

### P1 - Escritorio: cambios funcionales

1. Evitar credenciales MySQL en clientes de escritorio:
   - el escritorio no debe recibir `DATABASE_URL` ni usuario/password de BD;
   - usar API backend con token por dispositivo/usuario;
   - revocar credenciales por instalacion.
2. Cifrar SQLite local:
   - usar SQLCipher o cifrado de campos sensibles;
   - clave protegida con DPAPI/Windows Credential Manager o keyring;
   - no guardar `encryption_password` en claro.
3. Proteger cache offline:
   - cachear solo lo minimo;
   - cifrar workspaces, policies, config y refresh tokens;
   - caducidad y revalidacion periodica.
4. Eliminar temporales en claro de forma mas robusta:
   - crear temporales en directorio privado con permisos restrictivos;
   - usar nombres no derivados del archivo original;
   - borrar en `finally`;
   - evitar fallback silencioso a copiar claro cuando falla `SecureFileWriter`.
5. Corregir cifrado PDF:
   - usar AES-256 real con libreria compatible o herramienta probada (`qpdf`/pypdf moderno configurado);
   - registrar algoritmo/version;
   - validar que no se suba a nube si el cifrado falla.
6. Agregar retencion local:
   - limpiar `temp_workspace`, `processed`, `pending_review`, `cloud_output` y `local_queue.db` segun politica;
   - opcion de "borrado seguro razonable" y bitacora.
7. Endurecer UI Eel:
   - escapar nombres de workspace, rutas, nombres de archivo y errores antes de insertarlos con `innerHTML`;
   - validar sesion en `export_files`, `sync_now`, `get_queue_items` y demas funciones expuestas;
   - limitar Eel a localhost y revisar acceso desde navegador externo.
8. Minimizar logs:
   - evitar nombres de archivo con datos personales cuando no sean necesarios;
   - usar identificadores internos y hash/alias;
   - separar logs tecnicos de contenido documental.
9. Documentar operacion en estaciones:
   - permisos de carpeta `%LOCALAPPDATA%\GobernanzaDocumental`;
   - backups;
   - procedimiento de baja de empleado y limpieza de equipo;
   - instalacion sin copiar secretos de BD.

### P2 - Documentos y procesos internos

1. Politica de privacidad completa:
   - identidad, domicilio y contacto del titular/responsable;
   - finalidades;
   - datos tratados;
   - destinatarios/proveedores;
   - transferencias internacionales;
   - bancos de datos;
   - retencion;
   - derechos ARCO;
   - seguridad;
   - canales.
2. Avisos cortos por flujo:
   - login;
   - alta de usuarios por admin;
   - subida de documentos;
   - conexion Google Drive;
   - escritorio/OCR.
3. Canal ARCO operativo:
   - correo dedicado, por ejemplo `privacidad@...`;
   - formulario;
   - responsable interno;
   - registro de solicitudes;
   - plantillas de respuesta.
4. Contratos de encargo/subencargo:
   - clientes que usan la plataforma;
   - hosting/BD;
   - Google Drive/OAuth/reCAPTCHA;
   - soporte tecnico;
   - mantenimiento.
5. Plan de incidentes:
   - definicion de incidente;
   - severidades;
   - responsables;
   - recoleccion de evidencia;
   - decision ANPD/titulares en 48h cuando corresponda;
   - comunicacion al Centro Nacional de Seguridad Digital si el incidente ocurre en entorno digital y aplica;
   - registro de incidentes.
6. Documento de seguridad:
   - sistemas, roles, privilegios;
   - gestion de accesos;
   - controles de autenticacion;
   - backups;
   - logs;
   - cifrado;
   - retencion;
   - capacitacion;
   - revision semestral de privilegios.
7. Libro de Reclamaciones:
   - solo si el SaaS se ofrece a consumidores o mediante plataforma de ventas web;
   - aviso visible;
   - hoja virtual con copia/codigo;
   - flujo de respuesta escrita en 15 dias habiles;
   - conservacion de evidencias.

### P3 - Pruebas y gates antes de produccion

1. Gate legal:
   - politica publicada;
   - ARCO probado;
   - inventario y bancos listos/inscritos;
   - transferencias documentadas;
   - EIPD aprobada o justificacion de no aplicacion;
   - ODP designado o justificado.
2. Gate seguridad:
   - endpoints `/api/sync/*`, `/api/logs` y `/api/drive/folders` con auth real;
   - secretos cifrados y no legibles en UI;
   - PDF AES-256 verificado;
   - SQLite local cifrado;
   - rate limit de login;
   - logs con IP/user-agent;
   - pruebas de retencion.
3. Gate escritorio:
   - instalador sin copiar credenciales de BD;
   - cache offline cifrada;
   - temporales limpiados;
   - funciones Eel validadas por sesion;
   - prueba de desconexion/reconexion sin perder trazabilidad.
4. Gate evidencia:
   - pruebas automatizadas para permisos por rol/workspace;
   - tests de ARCO;
   - tests de retencion;
   - test de token invalido en APIs sync;
   - revision de dependencias y secret scanning.

## Orden recomendado de implementacion

1. Bloquear brechas de seguridad criticas: auth real en `/api/sync/*`, cerrar `POST /api/logs`, proteger `/api/drive/folders`, no tokens por query, no secretos en claro.
2. Crear documentos base de privacidad, ARCO, proveedores, transferencias, incidentes y documento de seguridad.
3. Implementar rutas web legales y registros de aceptacion/aviso.
4. Reemplazar acceso directo MySQL del escritorio por API con token por instalacion.
5. Cifrar secretos web y SQLite local.
6. Implementar retencion/supresion y limpieza de temporales.
7. Completar EIPD/ODP/Registro Nacional y revision legal.
8. Agregar Libro de Reclamaciones solo si hay venta/atencion a consumidores por web o establecimiento.

## Datos que faltan para cerrar el analisis legal

- Razon social, RUC, domicilio y representante legal.
- Correo y telefono de privacidad.
- Si el producto se vende B2B, B2C o se usa internamente.
- Paises de hosting, base de datos, despliegue y soporte.
- Tipo real de documentos que se escanean: RR.HH., contabilidad, salud, menores, legal, proveedores, clientes.
- Volumen estimado de titulares y documentos.
- Si ya existen bancos inscritos ante la ANPD.
- Si hubo incidentes previos.
- Politicas internas de confidencialidad/capacitacion.

## Conclusion

La base tecnica sirve para construir cumplimiento, pero hoy el sistema no esta listo para produccion con datos reales bajo un estandar peruano razonable. Lo mas urgente no es agregar mas UI, sino cerrar autenticacion de APIs, secretos, retencion, ARCO, privacidad, transferencias y documentacion de seguridad. Despues de eso se puede pasar a una revision legal formal con evidencia concreta y menos incertidumbre.
