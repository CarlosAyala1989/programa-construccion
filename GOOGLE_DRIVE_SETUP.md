# Configuración de Google Drive Picker API

Para que el selector de carpetas de Google Drive funcione en el panel del administrador, necesitas configurar un proyecto en Google Cloud y obtener las credenciales.

## Pasos a seguir:

1. **Crear un Proyecto en Google Cloud:**
   - Ve a la [Consola de Google Cloud](https://console.cloud.google.com/).
   - Crea un nuevo proyecto (ej. `Gobernanza Documental`).

2. **Habilitar la API de Google Drive:**
   - En el menú izquierdo, ve a **APIs & Services** > **Library**.
   - Busca `Google Drive API` y haz clic en **Habilitar** (Enable).

3. **Configurar la Pantalla de Consentimiento OAuth:**
   - Ve a **APIs & Services** > **OAuth consent screen**.
   - Selecciona **Externo** o **Interno** (Interno es recomendado si usas Google Workspace de empresa).
   - Rellena el Nombre de la App, Correo de soporte, y añade los scopes: `.../auth/drive.readonly` o `.../auth/drive`.
   - Guarda los cambios.

4. **Crear Credenciales (Client ID):**
   - Ve a **APIs & Services** > **Credentials**.
   - Clic en **Create Credentials** > **OAuth client ID**.
   - Tipo de aplicación: **Web application**.
   - En **Authorized JavaScript origins**, añade: `http://localhost:3000` (y tu dominio en producción).
   - Crea y copia el **Client ID**.

5. **Crear API Key:**
   - En la misma página de Credentials, haz clic en **Create Credentials** > **API key**.
   - Copia la **API Key**.

6. **Obtener el App ID:**
   - El App ID es el primer número (antes del guion) que aparece en tu Client ID. 
   - Por ejemplo, si tu Client ID es `123456789-abcdefg.apps.googleusercontent.com`, tu App ID es `123456789`.

## Configuración en el Código

Crea un archivo llamado `.env.local` en la carpeta `construccion-web/` y añade tus credenciales:

```env
NEXT_PUBLIC_GOOGLE_API_KEY="TU_API_KEY_AQUI"
NEXT_PUBLIC_GOOGLE_CLIENT_ID="TU_CLIENT_ID_AQUI.apps.googleusercontent.com"
NEXT_PUBLIC_GOOGLE_APP_ID="TU_APP_ID_AQUI"
```

Reinicia el servidor de Next.js (`npm run dev`) y el selector de Google Drive estará funcional.
