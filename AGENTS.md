# Repository Guidelines

## Project Structure & Module Organization

This repository contains two applications. `construccion-web/` is a Next.js 16 app: pages and API handlers live in `src/app/`, UI in `src/components/`, shared utilities in `src/lib/`, and database files in `prisma/`. `construccion-escritorio/` is the Python/Eel scanner client. Domain code is split across `src/core/`, `src/database/`, `src/hardware/`, and `src/sync/`; browser assets are in `web/`, packaging in `scripts/` and `installer/`, and runtime files in `data/`.

## Build, Test, and Development Commands

- `cd construccion-web && npm ci`: install locked dependencies and generate the Prisma client.
- `npm run dev`: serve the web application at `http://localhost:3000`.
- `npm run lint`: run TypeScript and Core Web Vitals ESLint rules.
- `npm run build && npm start`: create and serve a production build.
- `npx prisma migrate dev`: apply local schema migrations; use `npx prisma migrate deploy` in production.
- `cd construccion-escritorio && python -m venv venv && source venv/bin/activate && pip install -r requirements.txt`: prepare Python.
- `python main.py`: launch the Eel client at port 8765.
- `./scripts/build-online-installer-linux.sh`: build the Windows online installer from Linux.

## Coding Style & Naming Conventions

TypeScript is strict. Use two-space indentation, double quotes, and semicolons. Name React components and types in `PascalCase`, functions and variables in `camelCase`, and Next handlers `route.ts`. Use the `@/` alias for `src/`. Python uses four spaces, `snake_case` functions/modules, and `PascalCase` classes; keep concerns in their existing packages.

## Testing Guidelines

No automated test framework or coverage threshold is currently configured. Every change must pass `npm run lint` and `npm run build`; manually exercise affected pages/API routes and the desktop scan, OCR, encryption, and upload path as applicable. When introducing tests, use `*.test.ts(x)` for web code and `test_*.py` for Python, and document the runner in the relevant dependency manifest.

## Commit & Pull Request Guidelines

Recent history primarily uses Conventional Commit prefixes such as `feat:`, `docs:`, and `refactor:`. Continue with `<type>: <imperative summary>` and keep each commit focused. Pull requests should describe the problem and solution, identify the affected application, link the issue, list validation performed, call out migrations or new environment variables, and include screenshots for UI changes.

## Security & Configuration

Never commit `.env` files, database credentials, OAuth tokens, or generated runtime data. Web changes must also follow `construccion-web/AGENTS.md`; consult the installed Next.js 16 documentation before relying on framework conventions.
