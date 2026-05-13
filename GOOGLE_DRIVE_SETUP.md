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
5. Copia el **Client ID** generado

### 5. Configurar en el Proyecto

Agrega la siguiente variable al archivo `construccion-web/.env`:

```env
NEXT_PUBLIC_GOOGLE_CLIENT_ID="TU_CLIENT_ID_AQUI.apps.googleusercontent.com"
```

### 6. Reiniciar el Servidor

```bash
cd construccion-web
npm run dev
```

## ¿Cómo funciona?

1. El administrador va a **Espacios de Trabajo** en el dashboard
2. Hace clic en **📁 Elegir Carpeta** > pestaña **☁️ Google Drive**
3. Hace clic en **Explorar Google Drive** → se abre el navegador de carpetas
4. Inicia sesión con su cuenta de Google (solo la primera vez)
5. **Navega** por sus carpetas de Drive (clic = seleccionar, doble clic = abrir)
6. Puede **crear nuevas carpetas** desde la misma interfaz
7. Selecciona la carpeta destino → el sistema guarda el ID y la ruta
8. El programa de escritorio usará esa carpeta para subir los PDFs encriptados

## Flujo de seguridad

```
Documento → OCR → Políticas de Seguridad → Encriptación con contraseña → Google Drive
                                                                    o → Carpeta Local
                                                                    o → Dropbox
```

Los PDFs **siempre se encriptan antes** de subirse, independientemente del destino elegido.
