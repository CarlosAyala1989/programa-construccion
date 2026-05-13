# Configuración de Google Drive para la Plataforma

## Pasos para configurar la integración con Google Drive

### 1. Crear un Proyecto en Google Cloud Console

1. Ve a [Google Cloud Console](https://console.cloud.google.com/)
2. Crea un nuevo proyecto (o selecciona uno existente)
3. Dale un nombre descriptivo, ej: "Gobernanza Documental"

### 2. Habilitar la API de Google Drive

1. En el menú lateral, ve a **APIs & Services** > **Library**
2. Busca **Google Drive API**
3. Haz clic en **Enable**

### 3. Configurar la Pantalla de Consentimiento OAuth

1. Ve a **APIs & Services** > **OAuth consent screen**
2. Selecciona **External** (a menos que tengas Google Workspace)
3. Llena los campos requeridos:
   - **App name**: Gobernanza Documental
   - **User support email**: tu correo
   - **Developer contact**: tu correo
4. En **Scopes**, agrega:
   - `https://www.googleapis.com/auth/drive.file`
   - `https://www.googleapis.com/auth/drive.readonly`
5. En **Test users**, agrega los correos de las cuentas que usarán el sistema

### 4. Crear Credenciales OAuth 2.0

1. Ve a **APIs & Services** > **Credentials**
2. Haz clic en **Create Credentials** > **OAuth client ID**
3. Selecciona **Web application**
4. Configura:
   - **Name**: Gobernanza Web Client
   - **Authorized JavaScript origins**: 
     - `http://localhost:3000` (desarrollo)
     - `https://tu-dominio.com` (producción)
   - **Authorized redirect URIs**:
     - `http://localhost:3000` (desarrollo)
5. Copia el **Client ID** y el **Client Secret** generados

### 5. Configurar en el Proyecto

Agrega las siguientes variables al archivo `construccion-web/.env`:

```env
NEXT_PUBLIC_GOOGLE_CLIENT_ID="TU_CLIENT_ID.apps.googleusercontent.com"
GOOGLE_CLIENT_SECRET="TU_CLIENT_SECRET"
```

> **Importante**: El `GOOGLE_CLIENT_SECRET` se usa en el servidor para obtener un `refresh_token`, que es necesario para que el programa de escritorio pueda subir archivos sin necesidad de que el usuario inicie sesión en Google cada vez.

### 6. Configurar credenciales en la Web Admin (opcional)

Para que el escritorio pueda refrescar tokens automáticamente, ve a **Configuración** en el dashboard web y guarda las credenciales de Google en el campo `cloudCredentials` como JSON:

```json
{
  "clientId": "TU_CLIENT_ID.apps.googleusercontent.com",
  "clientSecret": "TU_CLIENT_SECRET"
}
```

### 7. Reiniciar el Servidor

```bash
cd construccion-web
npm run dev
```

## Flujo Completo

### Admin (Web):
1. Va a **Espacios de Trabajo** > clic en **📁 Elegir Carpeta** > pestaña **☁️ Google Drive**
2. Clic en **Explorar Google Drive** → Popup de login de Google
3. Navega sus carpetas, crea nuevas si es necesario
4. Selecciona la carpeta destino → se guarda:
   - `cloudPath`: La ruta legible (ej: "Google Drive: /Empresa/RRHH")
   - `cloudFolderId`: El ID de la carpeta en Drive (usado por la API)
   - `cloudRefreshToken`: El token de larga duración para subir archivos

### Escritorio (Desktop):
1. El empleado inicia sesión con sus credenciales
2. Selecciona su espacio de trabajo (que ya tiene el `cloudFolderId` y `cloudRefreshToken` configurados)
3. Escanea/importa documentos → se procesan (OCR, encriptación)
4. Al cerrar la sesión:
   - Se usa el `cloudRefreshToken` para obtener un `access_token` fresco
   - Se sube cada documento procesado a la carpeta `cloudFolderId` de Drive
   - **Sin necesidad de que el empleado inicie sesión en Google**

## Flujo de seguridad

```
Documento → OCR → Políticas de Seguridad → Encriptación con contraseña → Upload a Drive (via refresh_token)
                                                                    o → Carpeta Local
                                                                    o → Dropbox
```

Los PDFs **siempre se encriptan antes** de subirse, independientemente del destino.

## Solución de Problemas

### "No se obtuvo refresh_token"
Google solo devuelve el `refresh_token` la **primera vez** que el usuario autoriza la app. Si ya la autorizó antes:
1. Ve a [myaccount.google.com/permissions](https://myaccount.google.com/permissions)
2. Revoca el acceso a "Gobernanza Documental"
3. Vuelve a vincular la carpeta desde la web

### "Token refresh failed"
Asegúrate de que el `GOOGLE_CLIENT_SECRET` esté configurado correctamente tanto en el `.env` del servidor como en la tabla `Config.cloudCredentials`.
