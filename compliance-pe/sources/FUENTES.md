# Fuentes oficiales — corpus primario Perú

Objetivo: que toda afirmación legal generada por la skill sea reproducible y contrastable contra fuentes oficiales. La skill debe citar norma + artículo + archivo. Si una afirmación no se puede verificar contra estos archivos, debe marcarse como `[verificar contra fuente oficial]`.

## Fuentes mínimas

| Archivo local sugerido | Norma | Tipo | Fuente oficial | Estado |
|---|---|---|---|---|
| `ley-29733.pdf` | Ley N.° 29733, Ley de Protección de Datos Personales | PDF | Gob.pe / Congreso / El Peruano | descargar |
| `ley-29733.txt` | Ley N.° 29733 convertida a texto | TXT | derivado de PDF oficial | generar |
| `ds-016-2024-jus-reglamento.pdf` | D.S. N.° 016-2024-JUS, Reglamento de la Ley N.° 29733 | PDF | Gob.pe / El Peruano | descargar |
| `ds-016-2024-jus-reglamento.txt` | Reglamento convertido a texto | TXT | derivado de PDF oficial | generar |
| `rd-100-2025-jus-dgtaipd-odp.pdf` | Directiva ODP | PDF | ANPD / Gob.pe | descargar |
| `rm-476-2025-jus-sg-multas.pdf` | Metodología de cálculo de multas | PDF | ANPD / Gob.pe | descargar |

## URLs oficiales de referencia

- Ley N.° 29733 en Gob.pe: `https://www.gob.pe/institucion/congreso-de-la-republica/normas-legales/243470-29733`
- PDF Ley N.° 29733: `https://cdn.www.gob.pe/uploads/document/file/272360/Ley%20N%C2%BA%2029733.pdf.pdf?v=1618338779`
- D.S. N.° 016-2024-JUS en Gob.pe: `https://www.gob.pe/institucion/smv/normas-legales/6426760-016-2024-jus`
- D.S. N.° 016-2024-JUS en El Peruano: `https://busquedas.elperuano.pe/dispositivo/SE/2349653-1`
- PDF D.S. N.° 016-2024-JUS: `https://cdn.www.gob.pe/uploads/document/file/7568330/6426760-decreto-supremo-n-016-2024-jus-reglamento-de-la-ley-n-29733-ley-de-proteccion-de-datos-personales-publicado-nov-2024.pdf?v=1738386453`
- Directiva ODP R.D. N.° 100-2025-JUS-DGTAIPD: `https://www.gob.pe/institucion/anpd/normas-legales/7574631-100-2025-jus-dgtaipd`
- Metodología de multas R.M. N.° 476-2025-JUS/SG: `https://www.gob.pe/institucion/anpd/normas-legales/7575999-476-2025-jus-sg`
- Portal ANPD: `https://www.gob.pe/anpd`
- Campaña nuevo Reglamento: `https://www.gob.pe/institucion/anpd/campa%C3%B1as/128319-nuevo-reglamento-de-proteccion-de-datos-personales`

## Reglas de uso

1. Antes de afirmar una obligación legal, buscarla en `ley-29733.txt`, `ds-016-2024-jus-reglamento.txt` o norma oficial correspondiente.
2. Citar artículo y archivo fuente dentro de cada documento generado.
3. Usar fuentes secundarias solo como orientación inicial, nunca como base del documento final.
4. Si no existe texto local, pedir ejecutar `scripts/bootstrap-sources.sh`.
5. Mantener hash de cada archivo descargado para reproducibilidad.


## Fuentes para modo alto riesgo

Cuando se active `legal_review.required=true`, además de las fuentes mínimas debe revisarse si existe regulación sectorial aplicable. La skill no debe inventar obligaciones sectoriales; debe marcar `[verificar norma sectorial]` y preparar preguntas para abogado en salud, financiero/fintech, seguros, educación, laboral/RR.HH., telecomunicaciones, identidad digital, seguridad privada, legaltech o govtech.

Como mínimo, el expediente legal debe citar:

- Ley N.° 29733 para principios, consentimiento, datos sensibles, derechos, seguridad, confidencialidad, flujo transfronterizo y registro.
- D.S. N.° 016-2024-JUS para reglamento vigente, incidentes, EIPD, ODP, documento de seguridad, encargados y bancos de datos.
- R.D. N.° 100-2025-JUS-DGTAIPD para criterios y funciones del Oficial de Datos Personales.
- R.M. N.° 476-2025-JUS/SG para metodología de cálculo de multas cuando se evalúe riesgo sancionador.
