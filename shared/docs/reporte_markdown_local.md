# Especificación de fallback Markdown local

## Objetivo

Cuando `/report` no pueda usar Notion, debe dejar el reporte persistido localmente en un formato estable, versionable y fácil de revisar por el equipo.

## Estructura de carpetas

```text
reportes/
└── semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/
    ├── README.md
    └── {YYYY-MM-DD-dia}.md
```

Ejemplo:

```text
reportes/
└── semana-2026-04-06_a_2026-04-12/
    ├── README.md
    └── 2026-04-09-jueves.md
```

## Reglas obligatorias

- Crear una carpeta por semana con formato `semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}`.
- Crear un archivo por día con formato `YYYY-MM-DD-dia.md`.
- Si el archivo del día ya existe, reemplazar su contenido completo.
- No modificar archivos de días anteriores.
- Crear `README.md` semanal si no existe.

## Template del README semanal

```markdown
# Reportes semanales — Semana {{fecha_inicio}} a {{fecha_fin}}

- Rango: {{fecha_inicio}} a {{fecha_fin}}
- Backend: Markdown local (fallback de /report)

## Días registrados

- [{{Día}} {{DD/MM/YYYY}}]({{YYYY-MM-DD-dia}}.md)
```

Reglas:

- Agregar un bullet por día si todavía no existe.
- No duplicar entradas del mismo día.
- No borrar links previos.

## Template del archivo diario

```markdown
# Reporte diario — {{Día}} {{DD/MM/YYYY}}

- Fecha ISO: {{YYYY-MM-DD}}
- Semana: {{fecha_inicio}} a {{fecha_fin}}
- Destino: Markdown local

## Status

### Hecho

{{Qué funcionalidad quedó lista hoy, en primera persona y en términos de usuario/equipo.}}

### Pendiente

{{Qué funcionalidad quedó pendiente, en primera persona y sin detallar artefactos internos.}}

### Dudas

{{Bloqueos, decisiones pendientes o `Sin dudas abiertas por ahora.`}}

## Reporte técnico

### Introducción

{{Resumen técnico compacto del objetivo del día.}}

### Casos de uso

- {{Caso de uso 1}}
- {{Caso de uso 2}}

### Estructura

- `{{archivo_o_modulo_1}}` — {{rol}}
- `{{archivo_o_modulo_2}}` — {{rol}}

### Comportamiento

{{Descripción de validaciones, flujos y comportamiento implementado.}}

### Dudas abiertas

{{Preguntas pendientes o `Sin dudas abiertas al cierre del día.`}}

## Commit sugerido

```text
[ADD] relex_modulo: descripción corta
```
```

## Nota de estilo

- El bloque `Status` debe estar en primera persona singular.
- No mencionar SDD, apply, verify, batch ni términos internos del proceso.
- Priorizar funcionalidad y valor para usuario/equipo por encima del detalle técnico en `Status`.
