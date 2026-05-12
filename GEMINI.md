# Plataforma de Gobernanza Documental Inteligente

## Project Overview

This project is a hybrid distributed client-server architecture with Edge Computing for an intelligent documentary governance platform. It is split into two main environments:

1.  **Central Cloud (SaaS) - `construccion-web/`:** A Next.js based web application for configuring policies, visualizing reports, and centralized administration (RBAC).
2.  **Edge Environment (Desktop) - `construccion-escritorio/`:** A local "Fat Client" installed on the user's machine, built with Python and Eel, responsible for heavy computational tasks (IA, OCR, cryptography) in a zero-trust, offline-first manner.

### Core Technologies

*   **Cloud (Web):**
    *   Framework: Next.js (App Router, SSR)
    *   Language: TypeScript
    *   UI: React.js, Tailwind CSS
    *   ORM/Data: Prisma, MySQL
    *   Authentication: NextAuth.js (JWT)
*   **Edge (Desktop):**
    *   Core Logic: Python 3.10+
    *   UI Bridge: Eel (HTML/JS/CSS frontend bridging to Python backend)
    *   AI/Vision: PyTesseract (OCR), OpenCV
    *   Security: PyCryptodome (AES-256)
    *   Local DB: SQLite
    *   Hardware: TWAIN/WIA libraries (for scanners)

## Building and Running

### Web Environment (`construccion-web/`)
*   **Install Dependencies:**
    ```bash
    cd construccion-web
    npm install
    ```
*   **Database Setup:**
    Configure `DATABASE_URL` in `construccion-web/.env` and run:
    ```bash
    npx prisma db push
    ```
*   **Run Development Server:**
    ```bash
    npm run dev
    ```
    The application will run on `http://localhost:3000`.

### Desktop Environment (`construccion-escritorio/`)
*   **Setup Virtual Environment & Install Dependencies:**
    ```bash
    cd construccion-escritorio
    python3 -m venv venv
    source venv/bin/activate  # On Windows: venv\Scripts\activate
    pip install -r requirements.txt
    ```
    *Note: Hardware bridge libraries like `twain` may require Windows-specific environments.*
*   **Run Desktop Application:**
    ```bash
    python main.py
    ```

## Development Conventions

*   **Architecture Pattern (Web):** Monolithic Full-Stack Modular based on layers (BFF with Next.js API Routes).
*   **Architecture Pattern (Desktop):** Clean Architecture separating Python core logic from Eel UI. Follows Event-Driven Architecture (EDA) for UI updates without blocking, and Offline-First behavior (operations are local, then synchronized).
*   **Key Design Patterns (Desktop):**
    *   *Strategy*: For cloud upload synchronization (Google Drive, Dropbox).
    *   *Observer*: For Eel UI observing Python processing events (OCR/Encryption progress).
    *   *Unit of Work*: For atomic transactions when syncing local SQLite records to the cloud via Next.js.
