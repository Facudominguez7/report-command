Genera o actualiza el reporte diario en Notion o Markdown local siguiendo el workflow de la skill `internal-weekly-report`.

## Reglas Críticas de Redacción

- **NUNCA** mencionar SDD, pipeline, batch, apply, propose, verify, explore, spec, design ni ningún término del proceso interno.
- **Bloque 1** debe quedar en **primera persona singular**.
- **Bloque 2** puede ser técnico, pero debe describir resultados e implementación del módulo, no el proceso interno.
- Las reglas aplican **idénticamente** tanto para Notion como para Markdown local.

## Workflow Obligatorio (interactivo)

### Paso 1 — Recuperar Contexto del Día

- Buscar observaciones del día en Engram (`mem_context` + `mem_search` + `mem_get_observation`).
- Armar una lista breve de observaciones candidatas.
- **MOSTRAR al usuario las observaciones encontradas y PREGUNTAR cuáles quiere usar antes de continuar.**
- No avanzar sin la respuesta del usuario.

### Paso 1.5 — Confirmar Carpetas de Trabajo

- **PREGUNTAR al usuario en qué carpeta quiere ejecutar los comandos de Git/GitHub.**
- **PREGUNTAR al usuario en qué carpeta quiere que se guarden los reportes locales** (solo si el backend es Markdown).
  - Si ya existe una carpeta `reportes/` en la ubicación, informar y preguntar si quiere seguir ahí o elegir otra.
  - Si no existe, confirmar la ruta donde se va a crear.

### Paso 2 — Relevamiento Complementario

- Después de la respuesta del usuario, completar contexto con `git status`, `git diff`, `git log`.
- Recuperar dudas o bloqueos pendientes.

### Paso 3 — Redactar la Entrada Diaria

- Bloque 1: status conversacional en primera persona.
- Bloque 2: reporte técnico formal.
- Referencia: `shared/docs/reporte_diario_template.md`

### Paso 4 — Detectar Backend y Persistir

- Intentar Notion primero.
- Si Notion está disponible, buscar la página semanal vigente o crearla.
- Si Notion no está disponible, **preguntar al usuario en qué carpeta guardar los reportes**. Si ya existe una carpeta `reportes/`, confirmar si quiere seguir usándola o elegir otra. Usar la ruta confirmada en `reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/{YYYY-MM-DD-dia}.md`.
- Reemplazar o agregar la entrada del día sin duplicar fechas.
- Si se usa Markdown local, reemplazar el archivo completo del día si ya existe.
- No modificar entradas de días anteriores.

### Paso 4.5 — Autoverificación de Redacción (OBLIGATORIO)

Antes de escribir en cualquier backend, validar:

- [ ] El Status está en primera persona singular.
- [ ] El Status no contiene fórmulas impersonales (`se completó`, `se implementó`).
- [ ] Ningún bloque menciona SDD, apply, verify, batch ni términos del proceso interno.
- [ ] El Bloque 1 habla de funcionalidad, no de artefactos de código.
- [ ] El Bloque 2 describe implementación sin exponer el proceso interno de trabajo.

Si cualquier check falla, **rehacer el texto antes de persistir**.

### Paso 5 — Confirmar

Confirmar éxito sin devolver el texto completo del reporte. **Siempre especificar la ubicación exacta**: si fue Notion, indicar la página; si fue Markdown local, indicar la ruta completa del archivo.