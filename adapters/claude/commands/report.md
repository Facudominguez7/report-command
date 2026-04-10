Genera o actualiza el reporte diario en la página semanal de Notion y, si Notion no está disponible, lo guarda en Markdown local.

## Reglas Críticas de Redacción

- **NUNCA** mencionar SDD, pipeline, batch, apply, propose, verify, explore, spec, design ni ningún término del proceso interno.
- **Bloque 1** debe quedar en **primera persona singular**.
- **Bloque 2** puede ser técnico, pero debe describir resultados e implementación del módulo, no el proceso interno.

## Workflow Obligatorio

### Paso 1 — Recuperar Contexto del Día

- Usar Engram, GitHub y archivos del repo.
- Si falta contexto, preguntar.

### Paso 2 — Redactar la Entrada Diaria

- Bloque 1: status conversacional en primera persona.
- Bloque 2: reporte técnico formal.
- Referencia: `shared/docs/reporte_diario_template.md`

### Paso 3 — Verificar Página de la Semana Actual

- Intentar Notion primero.
- Si Notion está disponible, buscar la página semanal vigente.
- Si no existe, crearla.
- Si Notion no está disponible, usar Markdown local en `reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/{YYYY-MM-DD-dia}.md`.

### Paso 4 — Actualizar o Crear la Entrada del Día

- Reemplazar o agregar la entrada del día sin duplicar fechas.
- No modificar entradas previas.
- Si se usa Markdown local, reemplazar el archivo completo del día si ya existe.

### Paso 5 — Confirmar

Confirmar éxito sin devolver el texto completo del reporte e indicar si el destino final fue Notion o Markdown local.
