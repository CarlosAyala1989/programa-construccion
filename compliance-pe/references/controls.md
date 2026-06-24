# Catálogo de controles — compliance-pe

Formato: `ID | Control | Evidencia esperada | Base normativa | Riesgo si falta | Remediación`.

## Gobernanza y alcance

| ID | Control | Evidencia esperada | Base normativa | Riesgo | Remediación |
|---|---|---|---|---|---|
| PE-GOV-001 | Determinar si aplica normativa peruana | País de establecimiento, usuarios en Perú, medios en Perú, oferta dirigida o profiling | Reglamento arts. IV-VI | Alto | Documentar análisis de aplicabilidad |
| PE-GOV-002 | Identificar rol por flujo | Responsable/titular, encargado, subencargado, receptor | Ley art. 2; Reglamento art. III | Alto | Matriz de roles por flujo |
| PE-GOV-003 | Inventario de bancos/tratamientos | Lista de bancos, finalidades, datos, sistemas, titulares, encargados | Ley art. 34; Reglamento arts. 42-45 | Alto | Generar inventario y preparar inscripción |
| PE-GOV-004 | Responsable interno de privacidad | Persona/cargo, correo, funciones | Buen gobierno; ODP si aplica | Medio | Designar responsable interno mínimo |
| PE-GOV-005 | Oficial de Datos Personales cuando corresponda | Acta, contacto público, comunicación ANPD | Reglamento arts. 37-39; Directiva ODP | Alto | Generar acta ODP o justificar no obligatoriedad |
| PE-GOV-006 | Triage de alto riesgo y sector regulado | Nivel 1/2/3, banderas rojas, sector, decisión de revisión legal | Responsabilidad proactiva; Reglamento sobre EIPD/ODP/seguridad | Alto | Generar evaluación de alto riesgo y gates |

## Principios y bases de tratamiento

| ID | Control | Evidencia esperada | Base normativa | Riesgo | Remediación |
|---|---|---|---|---|---|
| PE-LAW-001 | Base legal por finalidad | Consentimiento o excepción documentada | Ley arts. 5, 13, 14 | Crítico | Matriz de bases por flujo |
| PE-LAW-002 | Consentimiento previo, informado, expreso e inequívoco | Checkbox no premarcado, timestamp, texto aceptado, IP/user-agent | Ley art. 13.5 | Crítico | Implementar registro de consentimiento |
| PE-LAW-003 | Consentimiento escrito/reforzado para datos sensibles | Documento o aceptación expresa trazable | Ley art. 13.6 | Crítico | Flujo reforzado y prueba exportable |
| PE-LAW-004 | Finalidad determinada y no cambio sin informar | Política, textos de formulario, código | Ley art. 6 | Alto | Alinear formularios y política |
| PE-LAW-005 | Minimización/proporcionalidad | Campos necesarios vs finalidad | Ley art. 7 | Medio | Eliminar campos innecesarios |
| PE-LAW-006 | Calidad y retención | Reglas de actualización, supresión y vencimiento | Ley art. 8 | Alto | Jobs de retención/borrado |

## Transparencia y derechos

| ID | Control | Evidencia esperada | Base normativa | Riesgo | Remediación |
|---|---|---|---|---|---|
| PE-TRN-001 | Política de privacidad accesible | URL o archivo visible antes de recopilar datos | Ley art. 18 | Alto | Generar política y linkear en UI |
| PE-TRN-002 | Información mínima completa | Finalidad, destinatarios, banco, titular, encargados, transferencias, retención, derechos | Ley art. 18 | Alto | Completar política y avisos cortos |
| PE-ARCO-001 | Canal ARCO | Correo/formulario, responsable, SLA, registro de solicitudes | Ley arts. 19-24 | Alto | Crear endpoint o correo dedicado |
| PE-ARCO-002 | Trazabilidad de solicitudes ARCO | Ticket, fecha, identidad verificada, respuesta | Ley arts. 19-24 | Alto | Registro interno ARCO |
| PE-ARCO-003 | Derecho a tratamiento objetivo | Explicación y revisión humana si hay decisiones automatizadas | Ley art. 23 | Alto | Documentar lógica y canal de revisión |

## Encargados, terceros y transferencias

| ID | Control | Evidencia esperada | Base normativa | Riesgo | Remediación |
|---|---|---|---|---|---|
| PE-DPA-001 | Contrato de encargo de tratamiento | Contrato con objeto, finalidad, instrucciones, seguridad, confidencialidad, subencargos | Ley art. 2; Reglamento arts. 31-33 [verificar numeración] | Alto | Generar contrato de encargo |
| PE-DPA-002 | Registro de proveedores | Proveedor, dato, finalidad, país, rol, contrato, subencargos | Ley art. 18; art. 15 | Alto | Crear anexo de proveedores |
| PE-XFER-001 | Flujo transfronterizo identificado | País, proveedor, tipo de datos, base, garantías | Ley art. 15; Reglamento arts. 19-21 | Alto | Generar anexo transferencia |
| PE-XFER-002 | Garantías para transferencia internacional | Nivel adecuado, cláusulas modelo u otro instrumento | Reglamento art. 20 | Alto | Incorporar cláusulas/garantías |
| PE-XFER-003 | Comunicación/registro de flujo transfronterizo | Evidencia de comunicación o preparación | Reglamento art. 21; Ley art. 34 | Medio | Preparar formulario e inventario |

## Seguridad e incidentes

| ID | Control | Evidencia esperada | Base normativa | Riesgo | Remediación |
|---|---|---|---|---|---|
| PE-SEC-001 | Medidas técnicas, organizativas y legales | HTTPS, hashing, cifrado, RBAC, backups, logs, política interna | Ley arts. 9 y 16 | Crítico | Plan de seguridad mínimo |
| PE-SEC-002 | Documento de seguridad | Documento con sistemas, controles, roles, riesgos y procedimientos | Reglamento arts. 46-47 | Alto | Generar documento de seguridad |
| PE-SEC-003 | Confidencialidad | Cláusulas laborales/proveedores, políticas internas | Ley art. 17 | Alto | Agregar cláusulas y capacitación |
| PE-SEC-004 | Gestión de secretos | `.env` fuera del repo, secret scanning, rotación | Ley arts. 9 y 16 | Crítico | Configurar secret scanning y vault/env |
| PE-SEC-005 | Audit log | actor, acción, fecha, IP, user-agent, entidad afectada | Ley arts. 9, 16; accountability | Alto | Implementar tabla/eventos de auditoría |
| PE-INC-001 | Plan de respuesta a incidentes | Roles, severidad, canales, 48 h, ANPD, CNSD si digital | Reglamento art. 34 | Crítico | Generar plan y runbook |
| PE-INC-002 | Registro de incidentes | Hechos, efectos, medidas, timestamps | Reglamento art. 35 | Alto | Crear registro de incidentes |
| PE-INC-003 | Obligación del encargado | Procedimiento de aviso inmediato al responsable | Reglamento art. 36 | Alto | Agregar cláusula y alerta técnica |

## Riesgos especiales

| ID | Control | Evidencia esperada | Base normativa | Riesgo | Remediación |
|---|---|---|---|---|---|
| PE-RISK-001 | EIPD para tratamientos de mayor riesgo | EIPD o justificación de no realización | Reglamento art. 40 | Alto | Generar EIPD recomendada |
| PE-RISK-002 | Menores y adolescentes | Consentimiento/representación, lenguaje claro, especial responsabilidad | Ley art. 13.3; Reglamento arts. 22-25 | Crítico | Flujo especial para menores |
| PE-RISK-003 | Perfilamiento | Documentación, finalidad, revisión humana, opt-out si aplica | Reglamento art. III.11; Ley art. 23 | Alto | Matriz de perfilamiento |
| PE-RISK-004 | Anonimización/disociación | Técnica, irreversibilidad/reversibilidad, pruebas | Reglamento art. 41 | Medio | Aplicar técnica adecuada |
| PE-RISK-005 | Marketing/prospección | Consentimiento previo y prueba de autorización | Ley arts. 5, 13, 18; Reglamento vigente | Alto | Separar opt-in comercial |


## Revisión legal y gates de producción

| ID | Control | Evidencia esperada | Base normativa | Riesgo | Remediación |
|---|---|---|---|---|---|
| PE-LEGAL-001 | Activar revisión legal en alto riesgo | `legal_review.required=true`, motivo y evidencias | Buen gobierno; responsabilidad proactiva | Alto | Generar expediente `.compliance/legal-review/` |
| PE-LEGAL-002 | Minuta de revisión legal | Preguntas concretas, documentos anexos, riesgos residuales | Buen gobierno; seguridad y accountability | Alto | Generar `lpdp-minuta-revision-legal.md` |
| PE-LEGAL-003 | Gates antes de producción | Lista de controles críticos cerrados/aprobados | Seguridad, consentimiento, transferencias, EIPD/ODP cuando aplique | Crítico | Generar `lpdp-plan-gates-produccion.md` |
| PE-LEGAL-004 | Registro de decisiones jurídico-técnicas | Decisión, alternativas, evidencia, base, aprobador | Responsabilidad proactiva | Medio | Mantener `lpdp-registro-decisiones-juridicas.md` |
| PE-LEGAL-005 | Revisión sectorial | Checklist salud/fintech/educación/laboral/telecom/govtech | Normativa sectorial [verificar] + LPDP | Alto | Marcar norma sectorial a revisar y responsable |
