# compliance-pe

### Cumplimiento de protección de datos para startups y SaaS peruanos, desde la terminal

`compliance-pe` es una skill estilo Claude Code para auditar un repositorio, mapear qué datos personales trata una aplicación y generar documentación base de cumplimiento para Perú: inventario de bancos/tratamientos, política de privacidad, autorización de tratamiento, canal de derechos ARCO, contrato de encargo, transferencias internacionales, documento de seguridad, plan de respuesta a incidentes, registro de incidentes, matriz de riesgos y acta de Oficial de Datos Personales cuando corresponda.

La idea es que un founder, equipo técnico o pequeña empresa pueda partir con un paquete razonable de cumplimiento sin esperar a contratar un estudio legal para el trabajo mecánico. Para casos de alto riesgo, fiscalizaciones, tratamiento masivo, datos sensibles, salud, menores, fintech, scoring, biometría o litigios, la skill no se queda en un aviso genérico: activa un modo de revisión legal, genera preguntas concretas, evidencias, matriz de decisiones y gates antes de producción para que el abogado revise sobre una base ordenada.

> **Aviso**: esta skill no constituye asesoría legal ni garantiza cumplimiento certificado. Genera borradores y controles técnicos fundados en normativa peruana. La responsabilidad final del tratamiento de datos recae en la organización que usa la herramienta.

## Qué hace

Al ejecutar `/compliance-pe` dentro de un repositorio:

1. Pregunta datos mínimos de la empresa o proyecto: razón social, RUC, domicilio, contacto, representante, giro, tamaño, si opera en Perú o atiende titulares ubicados en Perú.
2. Lee el código y detecta datos personales: nombres, correos, teléfonos, DNI, RUC, direcciones, IP, ubicación, identificadores en línea, imágenes, datos biométricos, salud, pagos, menores, conversaciones, logs y archivos subidos.
3. Identifica proveedores y transferencias: AWS, Google Cloud, Supabase, Vercel, OpenAI, Meta, SendGrid, Stripe, Firebase, S3, analytics, CRM, soporte, chat, correo y otros terceros.
4. Evalúa controles contra la Ley N.° 29733, el Reglamento aprobado por D.S. N.° 016-2024-JUS y directivas de la ANPD.
5. Genera documentos en `.compliance/docs/` y un `state.json` versionable con evidencia archivo:línea.
6. Explica cada decisión con norma + artículo + archivo fuente. Si no puede verificar una obligación en el corpus oficial local, marca `[verificar contra fuente oficial]`.
7. Propone remediaciones técnicas: consentimiento, endpoint ARCO, auditoría, retención, cifrado, borrado, minimización, documento de seguridad y flujo de incidentes.
8. Clasifica el proyecto en nivel self-service, revisión legal recomendada o alto riesgo/regulado.
9. Si hay alto riesgo, genera `.compliance/legal-review/` con minuta para abogado, checklist, preguntas, evidencias y gates antes de producción.

## Marcos cubiertos

| Pack | Marco | Estado | Cubre |
|---|---|---:|---|
| `lpdp-29733` | Ley N.° 29733 + D.S. N.° 016-2024-JUS | v0.1 | consentimiento, información, ARCO, bancos de datos, transferencias, seguridad, incidentes, ODP, EIPD, encargados |
| `directiva-odp` | R.D. N.° 100-2025-JUS-DGTAIPD | referenciado | criterios de designación, perfil, funciones e independencia del Oficial de Datos Personales |
| `multas-anpd` | R.M. N.° 476-2025-JUS/SG | referenciado | metodología de cálculo de multas y razonabilidad sancionadora |

## Modo alto riesgo / regulado

`compliance-pe` puede usarse también cuando el proyecto sí requiere revisión legal. En ese caso, su valor es preparar el expediente de revisión:

- detecta banderas rojas: datos sensibles, salud, biometría, menores, scoring, IA de impacto, grandes volúmenes, incidentes o fiscalización;
- identifica sectores que pueden requerir análisis adicional: salud, financiero/fintech, seguros, educación, laboral, telecomunicaciones, seguridad privada, identidad digital, legaltech o govtech;
- marca `legal_review.required = true` en `state.json`;
- genera `lpdp-evaluacion-alto-riesgo-regulado.md`;
- genera `lpdp-minuta-revision-legal.md`, `lpdp-checklist-abogado.md`, `lpdp-registro-decisiones-juridicas.md` y `lpdp-plan-gates-produccion.md`;
- convierte hallazgos técnicos en preguntas concretas para el abogado.

Así el abogado queda como revisor especializado de decisiones críticas, no como la persona que debe reconstruir todo desde cero.

## Instalación

```bash
# Copiar esta carpeta como skill
cp -r compliance-pe ~/.claude/skills/compliance-pe

# En Claude Code, dentro del repo a auditar:
/compliance-pe
```

## Salida esperada

```text
.compliance/
├── state.json
├── RESUMEN.md
├── INSTRUCTIVO.md
├── docs/
    ├── lpdp-inventario-bancos-tratamientos.md
    ├── lpdp-politica-privacidad.md
    ├── lpdp-autorizacion-consentimiento.md
    ├── lpdp-canal-derechos-arco.md
    ├── lpdp-contrato-encargo-tratamiento.md
    ├── lpdp-anexo-transferencias-internacionales.md
    ├── lpdp-documento-seguridad.md
    ├── lpdp-plan-respuesta-incidentes.md
    ├── lpdp-registro-incidentes.md
    ├── lpdp-eipd.md
    ├── lpdp-acta-designacion-odp.md
    ├── lpdp-matriz-riesgos.md
    ├── lpdp-evaluacion-alto-riesgo-regulado.md
    ├── lpdp-minuta-revision-legal.md
    ├── lpdp-checklist-abogado.md
    ├── lpdp-registro-decisiones-juridicas.md
    └── lpdp-plan-gates-produccion.md
└── legal-review/
    ├── 00-resumen-ejecutivo.md
    ├── 01-preguntas-para-abogado.md
    ├── 02-evidencias-codigo.md
    ├── 03-matriz-decisiones.md
    ├── 04-riesgos-residuales.md
    └── 05-gates-produccion.md
```

## Estructura

```text
SKILL.md
packs/lpdp-29733/pack.md
packs/lpdp-29733/templates/*.md
references/controls.md
references/output-model.md
references/mapa-articulos-lpdp-peru.md
references/instructivo-situaciones.md
references/cuando-acudir-a-abogado.md
references/enfoque-alto-riesgo-regulado.md
references/handoff-revision-legal.md
references/checklist-sectores-regulados.md
references/build/*.md
sources/FUENTES.md
scripts/bootstrap-sources.sh
```

## Fuentes oficiales

Las fuentes se documentan en `sources/FUENTES.md`. Para una ejecución rigurosa, descarga los PDFs oficiales con `scripts/bootstrap-sources.sh`, conviértelos a texto y deja los `.txt` dentro de `sources/`. La regla de la skill es: **si no está en fuentes oficiales locales, no se afirma como obligación cerrada**.

## Créditos y licencia

Inspirado en el enfoque del proyecto `compliance-cl` de Lelemon-studio, publicado con licencia MIT. Esta adaptación para Perú es una implementación original orientada a Ley 29733 y normativa ANPD.

MIT © 2026
