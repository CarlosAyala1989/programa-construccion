# Modelo de salida `.compliance/`

## `state.json`

```json
{
  "skill": "compliance-pe",
  "version": "0.1.0",
  "generated_at": "ISO-8601",
  "repo": "ruta",
  "organization": {
    "razon_social": "",
    "ruc": "",
    "domicilio": "",
    "contacto_privacidad": "",
    "representante": "",
    "tamano": "micro|pequena|mediana|grande|desconocido"
  },
  "applicability": {
    "aplica_peru": true,
    "fundamento": ["Reglamento art. VI"],
    "razones": []
  },
  "data_inventory": [],
  "providers": [],
  "international_transfers": [],
  "banks": [],
  "controls": [
    {
      "id": "PE-LAW-002",
      "status": "✅|⚠️|❌|❓",
      "risk": "bajo|medio|alto|critico",
      "evidence": ["archivo:linea"],
      "legal_basis": ["Ley 29733 art. 13.5"],
      "finding": "",
      "remediation": ""
    }
  ],
  "scores": {
    "lpdp-29733": {
      "total": 0,
      "passed": 0,
      "partial": 0,
      "failed": 0,
      "unknown": 0
    }
  },
  "decisions": {
    "odp_required": false,
    "eipd_recommended": false,
    "registry_action_required": true,
    "incident_plan_required": true
  },
  "risk_triage": {
    "level": "1-self-service|2-legal-review-recommended|3-high-risk-regulated",
    "red_flags": [],
    "regulated_sectors": [],
    "reasoning": ""
  },
  "legal_review": {
    "required": false,
    "recommended": false,
    "reasons": [],
    "questions_for_lawyer": [],
    "production_gates": [],
    "residual_risks": []
  },
  "documents": []
}
```

## `RESUMEN.md`

Debe contener:

1. Diagnóstico general.
2. Tabla de controles críticos.
3. Datos personales detectados.
4. Proveedores y transferencias.
5. Bancos de datos a inscribir/actualizar.
6. Documentos generados.
7. Remediaciones técnicas priorizadas.
8. Diferencias contra ejecución anterior, si existe.
9. Triage alto riesgo/regulado.
10. Gates antes de producción si `legal_review.required=true`.

## `INSTRUCTIVO.md`

Debe contener guías operativas para:

- solicitud ARCO;
- incidente de seguridad;
- fiscalización ANPD;
- actualización de banco de datos;
- transferencia internacional nueva;
- onboarding de proveedor;
- revisión trimestral/semestral;
- revisión legal de alto riesgo;
- salida a producción con datos reales.
