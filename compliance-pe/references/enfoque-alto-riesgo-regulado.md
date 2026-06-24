# Enfoque de alto riesgo, sectores regulados y revisión legal

`compliance-pe` no debe tratar los casos sensibles o regulados como un simple disclaimer. Debe clasificarlos, documentarlos y producir un paquete de revisión legal. El objetivo es que la organización llegue al abogado con inventario, evidencias, decisiones y preguntas concretas, no con el problema en blanco.

## Principio operativo

La skill trabaja en tres niveles:

| Nivel | Nombre | Qué permite | Salida esperada |
|---|---|---|---|
| 1 | Self-service inicial | Apps simples, pocos datos, sin datos sensibles, sin decisiones automatizadas relevantes | Documentos base + remediaciones técnicas |
| 2 | Self-service con revisión legal recomendada | Hay proveedores internacionales, marketing, datos de menores no sensibles, analytics, conversaciones o riesgo medio | Documentos base + matriz de riesgos + checklist de revisión |
| 3 | Alto riesgo / regulado | Datos sensibles, salud, biometría, scoring, IA de impacto, menores, grandes volúmenes, fiscalización o sector regulado | Documentos base + EIPD + minuta legal + gates antes de producción |

El nivel 3 no bloquea el trabajo técnico. La skill debe seguir generando documentación, pero debe marcar `legal_review.required = true` y agregar controles de salida antes de producción.

## Banderas rojas que activan alto riesgo

Activar `legal_review.required = true` si aparece uno o más de estos supuestos:

- Datos sensibles: salud, biometría, genética, origen racial o étnico, opiniones políticas, convicciones religiosas o filosóficas, afiliación sindical, vida sexual, datos emocionales o datos íntimos.
- Tratamiento de niñas, niños o adolescentes, especialmente si existe perfilamiento, comunidad, geolocalización, imágenes, educación o salud.
- Biometría o reconocimiento facial, huella, voz, firma biométrica o verificación de identidad automatizada.
- Salud, historia clínica, telemedicina, psicología, bienestar, fitness con inferencias de salud o seguros.
- Scoring, perfilamiento o decisiones automatizadas con efectos relevantes en crédito, empleo, educación, seguros, acceso a servicios, precios o seguridad.
- IA que analiza conversaciones, documentos, audio, video, imágenes, comportamiento, productividad, rendimiento o emociones.
- Grandes volúmenes de datos, monitoreo sistemático, analytics intensivo o tracking persistente.
- Transferencias internacionales complejas, subencargados opacos, entrenamiento de modelos con datos personales o proveedores sin región/retención clara.
- Incidente de seguridad, filtración, exposición pública, ransomware, pérdida de credenciales o acceso no autorizado.
- Fiscalización, reclamo, denuncia, procedimiento sancionador o medida correctiva ante ANPD.
- Actividades reguladas: salud, financiero, fintech, seguros, educación, telecomunicaciones, laboral/RR.HH., seguridad privada, biometría, identidad digital, legaltech con expedientes, govtech o contratación pública.

## Resultado esperado cuando hay alto riesgo

La skill debe generar, además de los documentos normales:

1. `lpdp-evaluacion-alto-riesgo-regulado.md`.
2. `lpdp-eipd.md` con análisis reforzado.
3. `lpdp-minuta-revision-legal.md`.
4. `lpdp-checklist-abogado.md`.
5. `lpdp-registro-decisiones-juridicas.md`.
6. `lpdp-plan-gates-produccion.md`.

## Gates antes de producción

Cuando `legal_review.required = true`, el `RESUMEN.md` debe incluir una sección **No pasar a producción sin cerrar**:

- Finalidad y base de tratamiento validada.
- Texto de consentimiento reforzado aprobado.
- Política de privacidad alineada con el flujo real.
- Contratos de encargo y subencargo revisados.
- Transferencias internacionales justificadas.
- Documento de seguridad aprobado.
- EIPD terminada y riesgos residuales aceptados por dirección.
- Plan de incidentes probado con simulacro.
- Canal ARCO operativo y con responsables.
- Decisión documentada sobre ODP.
- Evidencia de inscripción/actualización de bancos cuando corresponda.

## Cómo hablar con el usuario

Evitar respuestas genéricas como “consulte a un abogado”. En su lugar:

- Explicar qué parte sí automatizó la skill.
- Explicar qué decisión requiere revisión legal.
- Entregar una pregunta concreta para el abogado.
- Señalar evidencia técnica encontrada.
- Mantener el trabajo accionable.

Ejemplo:

> Se detectó tratamiento de datos de salud en `models/patient.ts` y envío a un proveedor externo de IA. La skill generó EIPD, anexo de transferencia y minuta legal. Antes de producción debe validarse: base de tratamiento, consentimiento reforzado, suficiencia de garantías internacionales y si corresponde designar ODP.

## Fuentes normativas de apoyo

Usar como corpus primario:

- Ley N.° 29733, especialmente principios, consentimiento, datos sensibles, seguridad, confidencialidad, derechos del titular, flujo transfronterizo y registro de bancos.
- Reglamento aprobado por D.S. N.° 016-2024-JUS, especialmente disposiciones sobre consentimiento, menores, encargados, incidentes, ODP, EIPD, documento de seguridad y registro.
- Directiva del Oficial de Datos Personales.
- Metodología vigente de cálculo de multas.

Si el corpus local no tiene el artículo exacto, marcar `[verificar contra fuente oficial]` y no inventar numeración.
