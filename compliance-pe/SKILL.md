---
name: compliance-pe
description: >-
  Skill para armar compliance de protección de datos en Perú. Se usa cuando el usuario pide cumplir la Ley N.° 29733, preparar privacidad, auditar datos personales, generar política de privacidad, autorización/consentimiento, contrato de encargo, inventario de bancos de datos, canal ARCO, documento de seguridad, plan de incidentes, EIPD, Oficial de Datos Personales, evaluación de alto riesgo, revisión legal o paquete para abogado. Audita un repositorio y genera documentación base para startups, SaaS o empresas que tratan datos personales de titulares ubicados en Perú, contrastando cada decisión contra fuentes oficiales locales. En casos sensibles, regulados o de alto riesgo, produce handoff legal, preguntas concretas, riesgos residuales y gates antes de producción.
license: MIT
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - Bash
  - AskUserQuestion
---

# compliance-pe — Motor de cumplimiento de datos personales para Perú

Auditar una aplicación contra el pack `lpdp-29733`, resolver decisiones con criterio normativo y generar documentación rellenada en `.compliance/`. El objetivo es que una startup o empresa peruana pueda partir con un cumplimiento operativo sin depender de un abogado para el trabajo mecánico, y que los casos sensibles, regulados o de alto riesgo queden organizados para revisión legal específica.

> **DISCLAIMER OBLIGATORIO** — No constituye asesoría legal ni garantiza cumplimiento certificado. Genera borradores fundados en normativa peruana para facilitar el cumplimiento. En casos sensibles, regulados o de alto riesgo, además de generar documentos, debe activar el modo de revisión legal, producir minuta para abogado, gates antes de producción y matriz de decisiones pendientes. La responsabilidad legal final corresponde al titular/responsable/encargado del tratamiento. Incluir este disclaimer al pie de cada documento legal generado.

## Modelo mental

- **Controles** = unidades reutilizables que satisfacen obligaciones legales y buenas prácticas técnicas. Catálogo: `references/controls.md`.
- **Pack** = normativa activable. Hoy: `packs/lpdp-29733/pack.md`.
- **Estado** = el output vive en `<repo>/.compliance/` y debe poder versionarse con git. Formato: `references/output-model.md`.
- **Fuentes oficiales** = `sources/`. Toda afirmación legal debe citar norma + artículo + archivo fuente. Si no se confirma, escribir `[verificar contra fuente oficial]`.
- **Evidencia** = archivo:línea del código auditado o respuesta explícita del cuestionario.

## Flujo

### Fase 0 — Encuadre y cuestionario

Mostrar el disclaimer y recoger los datos necesarios para no dejar documentos vacíos. Preguntar solo lo que no se pueda inferir del repo.

Recoger:

1. Ruta del repo a auditar y pack activo. Default: `lpdp-29733`.
2. Empresa/proyecto: razón social, RUC, domicilio, correo de privacidad, teléfono, representante legal, sector, tamaño según ventas UIT si lo conoce.
3. Rol por flujo: titular de banco de datos, responsable de tratamiento, encargado de tratamiento o ambos.
4. Si la app ofrece bienes/servicios a personas ubicadas en Perú o analiza comportamiento de titulares en Perú.
5. Finalidades: cuenta de usuario, facturación, soporte, marketing, analítica, seguridad, IA, recursos humanos, proveedores, pagos, comunidad, chat, almacenamiento documental.
6. Datos tratados: comunes, sensibles, biométricos, salud, menores, ubicación, financieros, imágenes, documentos, conversaciones, logs.
7. Proveedores externos, ubicación de hosting, país de tratamiento, subencargados y bases contractuales.
8. Plazos de retención por tipo de dato. Si no existen, proponer defaults razonables y marcarlos como recomendación.
9. Canal ARCO actual: correo, formulario, mesa de partes, plataforma u otro.
10. Existencia de bancos de datos inscritos en el Registro Nacional de Protección de Datos Personales.
11. Si existe Oficial de Datos Personales o responsable interno de privacidad.
12. Si hubo incidentes/brechas previas.

Si existe `.compliance/state.json`, leerlo y tratar la ejecución como reevaluación, mostrando diferencias.

### Fase 1 — Descubrimiento en código

No asumir. Recorrer el repo con `Glob`, `Grep` y `Read`.

Buscar datos personales y evidencias:

- Identidad/contacto: `name`, `nombre`, `apellido`, `email`, `correo`, `phone`, `telefono`, `dni`, `documento`, `ruc`, `address`, `direccion`.
- Credenciales/seguridad: `password`, `hash`, `token`, `session`, `jwt`, `mfa`, `otp`, `ip`, `user_agent`.
- Datos sensibles: `biometric`, `biometrico`, `fingerprint`, `face`, `health`, `salud`, `diagnostico`, `genetic`, `emocional`, `sindicato`, `religion`, `politica`, `sexual`.
- Menores: `minor`, `menor`, `nino`, `niño`, `edad`, `birth`, `fecha_nacimiento`.
- Ubicación y perfiles: `lat`, `lng`, `geo`, `location`, `tracking`, `profile`, `profiling`, `analytics`.
- Pagos/facturación: `card`, `payment`, `stripe`, `culqi`, `paypal`, `invoice`, `factura`.
- IA/conversaciones/documentos: `prompt`, `message`, `chat`, `conversation`, `file`, `document`, `ocr`, `embedding`.
- Proveedores: `.env*`, `package.json`, `requirements.txt`, `composer.json`, `docker-compose.yml`, `vercel`, `aws`, `gcp`, `azure`, `supabase`, `firebase`, `s3`, `sendgrid`, `twilio`, `openai`, `anthropic`, `stripe`, `meta`, `google-analytics`.
- Seguridad: TLS/HTTPS, cifrado en reposo, hashing fuerte, rotación de secretos, audit log, RBAC, segregación por tenant, backups, retención, borrado, anonimización/disociación.

### Fase 1.5 — Triage de alto riesgo, sectores regulados y revisión legal

Antes de cerrar controles, clasificar el proyecto en uno de tres niveles:

| Nivel | Estado | Criterio | Acción |
|---|---|---|---|
| 1 | Self-service inicial | Pocos datos, sin sensibles, sin menores, sin decisiones automatizadas relevantes | Generar paquete base |
| 2 | Revisión legal recomendada | Proveedores internacionales, marketing, analytics, conversaciones, riesgo medio | Generar paquete base + checklist legal |
| 3 | Alto riesgo / regulado | Datos sensibles, salud, biometría, menores, scoring, IA de impacto, grandes volúmenes, incidente, fiscalización o sector regulado | Generar paquete completo + `legal_review.required=true` + gates antes de producción |

Activar `legal_review.required = true` si aparece cualquiera de estas banderas:

- salud, biometría, genética, datos emocionales, vida sexual, afiliación sindical, convicciones religiosas/políticas u otros datos sensibles;
- menores o titulares vulnerables;
- IA, perfilamiento, scoring, decisiones automatizadas o monitoreo sistemático;
- crédito, seguros, fintech, salud, educación, laboral/RR.HH., telecomunicaciones, seguridad privada, identidad digital, legaltech, govtech;
- transferencias internacionales complejas o proveedores con subencargados opacos;
- brecha de seguridad, filtración, ransomware o acceso no autorizado;
- fiscalización, denuncia, reclamo o procedimiento ante ANPD.

Si hay nivel 3, no detener la generación. Continuar con inventario, documentos y remediaciones, pero agregar:

- `.compliance/legal-review/00-resumen-ejecutivo.md`;
- `.compliance/legal-review/01-preguntas-para-abogado.md`;
- `.compliance/legal-review/02-evidencias-codigo.md`;
- `.compliance/legal-review/03-matriz-decisiones.md`;
- `.compliance/legal-review/04-riesgos-residuales.md`;
- `.compliance/legal-review/05-gates-produccion.md`.

La respuesta al usuario no debe limitarse a “consulte a un abogado”. Debe indicar qué parte quedó automatizada, qué decisión específica requiere revisión y qué evidencia la sustenta.

### Fase 2 — Evaluar controles y resolver decisiones

Para cada control en `references/controls.md`, producir:

- estado: `✅ cumple`, `⚠️ parcial`, `❌ brecha`, `❓ no verificable por código`;
- evidencia: archivo:línea o respuesta del usuario;
- obligación o referencia legal: norma + artículo + archivo;
- riesgo: bajo, medio, alto o crítico;
- remediación concreta.

Resolver expresamente:

1. **Aplica normativa peruana**: si hay establecimiento en Perú, encargado que trata por cuenta de responsable peruano, oferta a titulares en Perú, análisis de comportamiento de titulares ubicados en Perú o pacto de ley peruana.
2. **Base de tratamiento**: consentimiento o excepción legal/contractual. Si hay marketing, prospección o datos sensibles, exigir control reforzado.
3. **Bancos de datos**: identificar qué bancos existen y si deben inscribirse/actualizarse.
4. **Transferencia internacional**: listar proveedores fuera de Perú; evaluar país adecuado, cláusulas/garantías, comunicación/registro y consentimiento cuando corresponda.
5. **Oficial de Datos Personales**: evaluar si es obligatorio por entidad pública, grandes volúmenes, afectación amplia, datos sensibles o giro principal con datos sensibles. Considerar cronograma progresivo si aplica.
6. **Incidentes**: si hay exposición de grandes volúmenes, datos sensibles o perjuicio a derechos, preparar notificación a ANPD máximo 48 horas desde conocimiento; si afecta derechos del titular, comunicación al titular dentro de 48 horas sin dilación indebida.
7. **EIPD**: en Perú es facultativa como mecanismo de responsabilidad proactiva, pero recomendarla en datos sensibles, perfilamiento, menores, vulnerables o grandes volúmenes.
8. **Documento de seguridad**: generar versión mínima si no existe.
9. **Derechos ARCO**: verificar canal, plazos, responsables internos y trazabilidad.

### Fase 3 — Generar documentación rellenada

Leer `packs/lpdp-29733/pack.md` y generar todos los templates en `.compliance/docs/`:

- `lpdp-inventario-bancos-tratamientos.md`
- `lpdp-politica-privacidad.md`
- `lpdp-autorizacion-consentimiento.md`
- `lpdp-canal-derechos-arco.md`
- `lpdp-contrato-encargo-tratamiento.md`
- `lpdp-anexo-transferencias-internacionales.md`
- `lpdp-documento-seguridad.md`
- `lpdp-plan-respuesta-incidentes.md`
- `lpdp-registro-incidentes.md`
- `lpdp-eipd.md`
- `lpdp-acta-designacion-odp.md`
- `lpdp-matriz-riesgos.md`
- `lpdp-evaluacion-alto-riesgo-regulado.md`
- `lpdp-minuta-revision-legal.md`
- `lpdp-checklist-abogado.md`
- `lpdp-registro-decisiones-juridicas.md`
- `lpdp-plan-gates-produccion.md`

Reemplazar placeholders con datos del cuestionario y hallazgos del código. Usar `[COMPLETAR: ...]` solo si el dato es genuinamente desconocido. No dejar secciones vacías.

### Fase 4 — Estado versionado

Escribir:

- `.compliance/state.json`: controles, evidencias, score por marco, brechas, proveedores, bancos, transferencias y decisiones.
- `.compliance/RESUMEN.md`: diagnóstico, brechas priorizadas, documentos generados, diff vs corrida anterior.
- `.compliance/INSTRUCTIVO.md`: guías de ARCO, incidente, fiscalización, revisión periódica.
- `.compliance/docs/`: documentos finales.
- `.compliance/legal-review/`: expediente de revisión legal cuando exista alto riesgo o sector regulado.

Sugerir commit:

```bash
git add .compliance
git commit -m "chore: add Peru data protection compliance baseline"
```

### Fase 5 — Remediación técnica

Ofrecer construir en una rama los controles faltantes, siguiendo `references/build/`:

- consentimiento y doble opt-in;
- endpoints ARCO;
- audit log con actor, IP, user-agent, fecha y acción;
- retención y borrado programado;
- cifrado en reposo y gestión de secretos;
- documento de seguridad;
- flujo de incidentes y reporte;
- registro de proveedores y transferencias.

## Reglas

- Fuente de verdad: `sources/`. Cita norma + artículo + archivo.
- No usar blogs como base normativa final. Pueden servir solo para pistas, nunca como sustento.
- No prometer certificación ni cumplimiento garantizado.
- Distinguir siempre: titular de banco de datos, responsable, encargado, subencargado, receptor/importador.
- Si no hay corpus oficial descargado, avisar y usar `sources/FUENTES.md` para descargarlo antes de afirmar obligaciones finas.
- Resolver las decisiones que sí se puedan resolver con evidencia; no mandar todo al abogado.
- No usar la revisión legal como evasiva. Si hay fiscalización, reclamo ante ANPD, datos sensibles a escala, menores, biometría, salud, scoring, IA de alto impacto, transferencia compleja o riesgo sancionador alto, activar `legal_review.required=true`, generar expediente para abogado y marcar gates antes de producción.

## Recursos

- `sources/FUENTES.md` — fuentes oficiales y comandos de descarga.
- `references/controls.md` — catálogo de controles.
- `references/mapa-articulos-lpdp-peru.md` — mapa normativo inicial.
- `references/output-model.md` — formato del estado.
- `references/instructivo-situaciones.md` — runbooks.
- `references/cuando-acudir-a-abogado.md` — límites self-service.
- `references/enfoque-alto-riesgo-regulado.md` — modo sensible/regulado y gates de producción.
- `references/handoff-revision-legal.md` — expediente para abogado.
- `references/checklist-sectores-regulados.md` — salud, fintech, educación, laboral, telecom, govtech/legaltech.
- `references/build/` — recetas técnicas de remediación.
- `packs/lpdp-29733/` — obligaciones y plantillas.
