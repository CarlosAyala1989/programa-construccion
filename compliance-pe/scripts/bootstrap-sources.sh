#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")/../sources"
UA="Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 Chrome/124.0 Safari/537.36"

curl -L -A "$UA" "https://cdn.www.gob.pe/uploads/document/file/272360/Ley%20N%C2%BA%2029733.pdf.pdf?v=1618338779" -o ley-29733.pdf
curl -L -A "$UA" "https://cdn.www.gob.pe/uploads/document/file/7568330/6426760-decreto-supremo-n-016-2024-jus-reglamento-de-la-ley-n-29733-ley-de-proteccion-de-datos-personales-publicado-nov-2024.pdf?v=1738386453" -o ds-016-2024-jus-reglamento.pdf

if command -v pdftotext >/dev/null 2>&1; then
  pdftotext -layout ley-29733.pdf ley-29733.txt
  pdftotext -layout ds-016-2024-jus-reglamento.pdf ds-016-2024-jus-reglamento.txt
else
  echo "pdftotext no está instalado. Instala poppler-utils para generar los .txt."
fi

sha256sum *.pdf *.txt 2>/dev/null | tee SHA256SUMS.txt
