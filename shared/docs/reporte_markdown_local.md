# Especificación compacta: fallback Markdown local

## Persistencia

Cuando Notion no esté disponible, `/report` persiste en:

```text
reportes/
└── semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/
    ├── README.md
    └── {YYYY-MM-DD-dia}.md
```

## Reglas mínimas

- Preguntar y confirmar con el usuario la carpeta base antes de escribir.
- Si ya existe `reportes/`, informar y confirmar si se reutiliza.
- Crear carpeta semanal `semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}`.
- Crear/reemplazar el archivo diario `YYYY-MM-DD-dia.md`.
- No modificar días anteriores.
- Crear `README.md` semanal si falta.
- Confirmar siempre la ruta completa del archivo generado.

## README semanal (base)

```markdown
# Reportes semanales — Semana {{fecha_inicio}} a {{fecha_fin}}

- Rango: {{fecha_inicio}} a {{fecha_fin}}
- Backend: Markdown local (fallback de /report)

## Días registrados

- [{{Día}} {{DD/MM/YYYY}}]({{YYYY-MM-DD-dia}}.md)
```

## Archivo diario (base)

```markdown
# Reporte diario — {{Día}} {{DD/MM/YYYY}}

- Fecha ISO: {{YYYY-MM-DD}}
- Semana: {{fecha_inicio}} a {{fecha_fin}}
- Destino: Markdown local

## Status

### Hecho
{{Funcionalidad terminada en primera persona singular.}}

### Pendiente
{{Funcionalidad pendiente en primera persona singular.}}

### Dudas
{{Bloqueos o `Sin dudas abiertas por ahora.`}}

## Reporte técnico

### Introducción
{{Objetivo del día.}}

### Casos de uso
- {{Caso 1}}

### Estructura
- `{{archivo_o_modulo}}` — {{rol}}

### Comportamiento
{{Validaciones y lógica aplicada.}}

### Dudas abiertas
{{Pendientes o `Sin dudas abiertas al cierre del día.`}}
```
