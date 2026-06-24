# Handoff para revisión legal

Este archivo define cómo `compliance-pe` debe preparar la revisión de un abogado cuando el proyecto tiene riesgo sensible, regulado o sancionador.

## Objetivo

Reducir el costo y tiempo de revisión legal entregando un expediente técnico-jurídico ordenado:

- Qué datos se tratan.
- Dónde están en el código.
- Para qué se usan.
- Qué proveedores intervienen.
- Qué flujos internacionales existen.
- Qué documentos se generaron.
- Qué controles faltan.
- Qué decisiones requieren criterio legal.

## Expediente mínimo para abogado

Generar en `.compliance/legal-review/`:

```text
.compliance/legal-review/
├── 00-resumen-ejecutivo.md
├── 01-preguntas-para-abogado.md
├── 02-evidencias-codigo.md
├── 03-matriz-decisiones.md
├── 04-riesgos-residuales.md
├── 05-gates-produccion.md
└── anexos/
    ├── politica-privacidad.md
    ├── consentimiento.md
    ├── contrato-encargo.md
    ├── transferencias.md
    ├── eipd.md
    └── documento-seguridad.md
```

## Preguntas que la skill debe formular

Cuando haya alto riesgo, convertir hallazgos en preguntas concretas:

| Hallazgo | Pregunta legal concreta |
|---|---|
| Datos sensibles | ¿La base de tratamiento y el consentimiento reforzado son suficientes para esta finalidad? |
| Menores | ¿El flujo de autorización y verificación de representante cumple el estándar aplicable? |
| IA/perfilamiento | ¿La explicación al titular y la revisión humana son suficientes? |
| Transferencia internacional | ¿Las garantías contractuales y subencargados son aceptables para este flujo? |
| Salud/fintech/educación | ¿Existe normativa sectorial adicional que deba incorporarse? |
| Incidente | ¿La notificación a ANPD/titulares es obligatoria y cuál debe ser su alcance? |
| ODP | ¿La organización cae en supuesto de designación obligatoria o conviene designarlo voluntariamente? |
| Banco de datos | ¿Qué bancos deben inscribirse, modificarse o cancelarse? |

## Matriz de revisión

La minuta debe clasificar cada punto como:

- `aprobado por evidencia`;
- `requiere confirmación legal`;
- `requiere decisión de negocio`;
- `requiere cambio técnico`;
- `no apto para producción`.

## Reglas de redacción

- No usar lenguaje alarmista.
- No decir que la organización está incumpliendo sin evidencia.
- Diferenciar riesgo técnico, riesgo legal y riesgo reputacional.
- Citar artículos solo cuando estén verificados en fuentes locales.
- Conservar trazabilidad archivo:línea para hallazgos técnicos.
- Señalar qué documento exacto debe revisar el abogado.
