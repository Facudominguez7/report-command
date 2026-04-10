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

## Reglas de redacción obligatorias (aplican idénticamente a Notion y Markdown local)

### Regla de estilo para el Bloque 1 (Status)

- El bloque `Status` debe estar en **primera persona singular**.
- **SIEMPRE** usar formulaciones como: `hoy terminé`, `dejé`, `me quedó`, `estuve`, `avancé`, `corregí`.
- **NUNCA** usar formulaciones impersonales o pasivas como: `se completó`, `se implementó`, `se corrigió`, `se dejó`, `se avanzó`.

### Prohibiciones para el Bloque 1 (Status)

- **NUNCA** mencionar nombres de modelos ORM, campos técnicos (one2many, many2many, Char, Float), nombres de archivos Python, XML ni rutas internas del proyecto.
- **NUNCA** mencionar excepciones técnicas (ValidationError, UniqueViolation, IntegrityError), índices SQL, ni detalles de tests unitarios.
- **NUNCA** usar argot técnico de framework (ACLS, record rules, computations, onchange, constraints) — traducir SIEMPRE a funcionalidad de negocio.
- **NUNCA** listar artefactos de desarrollo (modelos, vistas, wizards, security) como logros — el logro es la **funcionalidad** que esos artefactos habilitan.

**Ejemplo MALO**: "Se completó el batch 2: 4 modelos bridge, integración base one2many, ACLs y tests del lote."

**Ejemplo BUENO**: "Hoy cerramos la configuración de regímenes especiales — ya se pueden dar de alta y vincular desde el formulario."

### Prohibiciones para el Bloque 2 (Reporte Técnico)

- **NUNCA** mencionar SDD, apply, verify, batch ni términos del proceso interno.
- **SIEMPRE** reescribir en términos neutros de implementación o resultado.
- **SIEMPRE** priorizar qué cambió en la funcionalidad, no cómo se organizó el proceso de trabajo.

### Autoverificación obligatoria

Antes de persistir el archivo, verificar:

- [ ] El Status está en primera persona singular.
- [ ] El Status no contiene fórmulas impersonales.
- [ ] Ningún bloque menciona términos del proceso interno.
- [ ] El Bloque 1 habla de funcionalidad, no de artefactos de código.
- [ ] El Bloque 2 describe implementación sin exponer el proceso interno.
