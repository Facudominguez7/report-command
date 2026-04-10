---
name: internal-weekly-report
description: >
  Genera o actualiza el reporte diario en la página semanal de Notion y, si Notion no está disponible, lo guarda en Markdown local.
  Trigger: uso interno del comando "/report".
  Aplica reglas estrictas de redacción a ambos backends.
license: Apache-2.0
metadata:
  author: relex
  version: "2.3.0"
---

## Cuándo Usar

Únicamente cuando el orquestador delega la generación del reporte diario vía el comando `/report`. No debe invocarse manualmente como comando de usuario.

---

## Backend Dual

- **Backend preferido**: página semanal de Notion usando MCP.
- **Backend de fallback**: archivo Markdown local dentro del repositorio cuando Notion no está disponible o no está configurado.

Las reglas de redacción de esta skill aplican **idénticamente** a ambos backends. No se relaja ninguna regla por usar Markdown local.

---

## Reglas Críticas (DO NOT)

- **NUNCA** crear una página por día — usar exclusivamente el formato de registro semanal.
- **NUNCA** mencionar cambios en `AGENTS.md` en ningún bloque.
- **NUNCA** inventar estado ni asumir trabajo no confirmado — si falta dato, marcá "pendiente de confirmación".
- **NUNCA** incluir inventarios internos de carpetas ni detalle técnico fino.
- **NUNCA** mencionar SDD, pipeline, batch, apply, propose, verify, explore, spec, design ni ningún término del proceso interno de desarrollo en ningún bloque.
- **SIEMPRE** buscar primero en Engram las observaciones del día antes de redactar.
- **SIEMPRE** mostrar al usuario las observaciones encontradas y preguntarle cuáles quiere usar antes de continuar.
- **SIEMPRE** preguntar al usuario en qué carpeta ejecutar los comandos de Git/GitHub antes de correrlos.
- **SIEMPRE** intentar Notion primero y hacer fallback automático a Markdown local si no está disponible.
- **SIEMPRE** preguntar al usuario dónde guardar los reportes locales si el backend es Markdown, y confirmar la ubicación antes de escribir.
- **SIEMPRE** especificar en la confirmación final la ruta exacta donde se guardó el reporte.
- **NUNCA** mostrar el texto completo del reporte en el chat.

### Regla obligatoria de estilo para el Bloque 1

El **Status** debe quedar redactado en **primera persona singular**.

- **SIEMPRE** usar formulaciones como: `hoy terminé`, `dejé`, `me quedó`, `estuve`, `avancé`, `corregí`.
- **NUNCA** usar formulaciones impersonales o pasivas como: `se completó`, `se implementó`, `se corrigió`, `se dejó`, `se avanzó`.
- Si el texto se puede leer como changelog técnico y no como mensaje humano, está MAL.

### Prohibiciones específicas para el Bloque 1 (Status)

El Bloque 1 es un mensaje **humano y conversacional**. Estas prohibiciones son ABSOLUTAS:

- **NUNCA** mencionar nombres de modelos ORM, campos técnicos (one2many, many2many, Char, Float), nombres de archivos Python, XML ni rutas internas del proyecto.
- **NUNCA** mencionar excepciones técnicas (ValidationError, UniqueViolation, IntegrityError), índices SQL, ni detalles de implementación de tests unitarios.
- **NUNCA** usar argot técnico de framework (ACLS, record rules, computations, onchange, constraints) — traducir SIEMPRE a funcionalidad de negocio.
- **NUNCA** listar artefactos de desarrollo (modelos, vistas, wizards, security) como si fueran logros — el logro es la **funcionalidad** que esos artefactos habilitan.

**Ejemplo MALO** (lo que NO debe salir):

> Jornada full en SDD apply para regímenes especiales. Se completó el batch 2: 4 modelos bridge, integración base one2many en modelos padre, pestañas/listados en vistas, ACLs y tests del lote. Hubo un fix de deduplicación SQL donde el test esperaba ValidationError pero el índice parcial lanza excepción SQL directa. Mañana: batch 3 (servicios domain end-to-end).

**Ejemplo BUENO** (lo que SÍ debe salir):

> Hoy cerramos la configuración de regímenes especiales y datos extra para partidas y parcelas — ya se pueden dar de alta y vincular desde el formulario. También corregimos un problema de duplicación que impedía registrar un mismo régimen dos veces. Queda pendiente unificar la interfaz entre lo nuevo y las pantallas existentes de datos extra. Mañana seguimos con los servicios de validez por fecha.

La diferencia clave: el Bloque 1 describe **qué puede hacer el usuario ahora** que antes no podía, no **qué código se escribió**.

### Prohibiciones específicas para el Bloque 2 (Reporte Técnico)

El Bloque 2 puede ser técnico, pero NO debe filtrar terminología del proceso interno.

- **NUNCA** mencionar SDD, pipeline, batch, apply, propose, verify, explore, spec, design, ni nombres de fases internas.
- **NUNCA** usar frases como `se completó el ciclo SDD`, `pasó por verify`, `batch 2`, `fase apply`, `exploración SDD`.
- **SIEMPRE** reescribir ese contexto en términos neutros de implementación o resultado, por ejemplo: `se completó la incorporación`, `se terminó la integración`, `se validó el comportamiento`, `se corrigió la regla de duplicados`.
- **SIEMPRE** priorizar qué cambió en la funcionalidad o en la estructura técnica del módulo, no cómo se organizó el proceso de trabajo.

**Ejemplo MALO**:

> Se completó el ciclo SDD apply del batch 2 y luego pasó por verify con corrección de tests.

**Ejemplo BUENO**:

> Se completó la incorporación de asociaciones de regímenes especiales y datos extra en partidas y parcelas, junto con sus validaciones y cobertura de pruebas.

---

## Delegación: Sub-Agente Efímero (OBLIGATORIO)

Esta tarea se delega SIEMPRE a un sub-agente efímero para aislar el contexto de la sesión principal. El orquestador no ejecuta los pasos directamente.

---

## Workflow del Sub-Agente (6 Pasos Exactos)

### Paso 1 — Recuperar Contexto del Día

Antes de redactar nada, recuperar TODO el contexto disponible del día:

1. `mem_context` → historial de sesión reciente
2. `mem_search` con keywords del trabajo del día → `mem_get_observation` para contenido completo
   - **OBLIGATORIO:** Extraer el nombre del módulo de los archivos modificados (ej: `relex_cat_base`, `relex_immovables_paperwork`) y usarlo como keyword principal en la búsqueda.
   - Si hay múltiples módulos, hacer una búsqueda por módulo.
3. Armar una lista breve de observaciones candidatas para el reporte
4. **PREGUNTAR al usuario cuáles quiere usar** antes de continuar

No seguir con la redacción ni con la persistencia final hasta que el usuario responda.

### Paso 1.5 — Confirmar Carpetas de Trabajo

Antes de correr cualquier comando o persistir nada:

1. **PREGUNTAR al usuario** en qué carpeta o repositorio quiere que se ejecuten los comandos de Git/GitHub.
2. **PREGUNTAR al usuario** en qué carpeta quiere que se guarden los reportes locales (solo si el backend es Markdown).
   - Si ya existe una carpeta `reportes/` en algún lugar propuesto, informar que existe y preguntar si quiere seguir guardando ahí o elegir otra ubicación.
   - Si no existe, confirmar la ruta donde se va a crear.
3. Esperar las respuestas del usuario antes de continuar.

### Paso 2 — Relevamiento Complementario

Después de que el usuario elija qué observaciones usar y confirme la carpeta:

1. `git status` + `git diff --name-only HEAD` + `git branch` + `git log --oneline --since=today`
2. De la salida de git, extraer: nombre(s) de módulo, entidades de negocio afectadas y usarlas como keywords en `mem_search`
3. Recuperar dudas, consultas o limitaciones técnicas pendientes

### Paso 3 — Redactar la Entrada Diaria

Layout **fijo y obligatorio** con exactamente DOS bloques en este orden:

#### Bloque 1 — Status (conversacional)

- **Tono**: español rioplatense, primera persona, breve, como si le contaras a un compañero de equipo qué hiciste hoy.
- **Contenido**: exactamente TRES cosas en este orden:
  1. **Qué funcionalidad se completó hoy** — en términos de lo que el usuario puede hacer ahora (no código escrito).
  2. **Qué queda pendiente** — en términos de funcionalidad que falta, no de tareas técnicas.
  3. **Dudas o bloqueos** — si los hay; si no, simplemente no los mencionás.
- **Presentación visual**: tabla simple corta con columnas `Hecho | Pendiente | Dudas` si el backend lo soporta; si no, lista compacta con ✅ 🔄 ❓.
- **Chequeo obligatorio**: antes de publicar, releer el párrafo y confirmar que todos los verbos principales estén en primera persona singular.

#### Bloque 2 — Reporte Técnico (formal)

Secciones obligatorias **en este orden**:

```
### Introducción
### Casos de uso
### Estructura
### Comportamiento
### Dudas abiertas
```

- Funcionalidad involucrada
- Archivos o módulos tocados (wizards, vistas, modelos, docs — cuando existan)
- Diagrama Mermaid como **bloque de código** si aporta claridad
- Al final del Bloque 2, proponer un **nombre de commit con estilo Odoo** acorde al trabajo del día.

### Paso 4 — Detectar Backend Disponible y Persistir

1. Intentar usar primero una herramienta MCP de Notion disponible en la sesión.
2. Si la herramienta existe y responde, considerá **Notion disponible**.
3. Si la herramienta no existe, falla por configuración o devuelve error de acceso, considerá **Notion no disponible** y seguí con Markdown local.
4. No interrumpir la sesión por ausencia de Notion.

**Si Notion está disponible**:
- Buscar la página semanal vigente en Notion.
- Si no existe, crear nueva página con título tipo `"Reporte Semanal — Semana del DD/MM/AAAA"`.
- Agregar o reemplazar la entrada del día sin duplicar fechas y sin modificar días anteriores.
- Agregar un encabezado explícito con el día y fecha en español antes de los dos bloques:
  ```markdown
  ## Jueves 10/04/2026
  ```

**Si Notion no está disponible**:
- Usar la carpeta confirmada por el usuario en el Paso 1.5.
- Si el usuario no especificó una carpeta, proponer la raíz del repositorio y confirmar antes de escribir.
- Verificar si ya existe una carpeta `reportes/` en la ubicación elegida.
  - Si existe: informar al usuario y preguntar si quiere seguir usando esa carpeta o elegir otra.
  - Si no existe: confirmar la ruta completa donde se va a crear y esperar aprobación.
- Crear la carpeta `{ruta_elegida}/reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/` si no existe.
- Crear `{ruta_elegida}/reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/README.md` si no existe y agregar el link del día.
- Crear o actualizar el archivo `{ruta_elegida}/reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/{YYYY-MM-DD-dia}.md`.
- Si el archivo del día ya existe, reemplazar su contenido completo.
- No modificar archivos de días anteriores.
- Usar `shared/docs/reporte_markdown_local.md` como referencia obligatoria del formato.

### Paso 4.5 — Autoverificación de Redacción (OBLIGATORIO)

Antes de escribir en cualquier backend (Notion o Markdown local), validar esta checklist:

- [ ] El **Status** está redactado en **primera persona singular**.
- [ ] El **Status** no contiene `se completó`, `se implementó`, `se corrigió` ni otras fórmulas impersonales.
- [ ] Ningún bloque menciona `SDD`, `apply`, `verify`, `explore`, `spec`, `design`, `batch` o términos equivalentes.
- [ ] El **Bloque 1** habla de funcionalidad para usuario o equipo, no de artefactos de código.
- [ ] El **Bloque 2** describe implementación y comportamiento del módulo sin exponer el proceso interno de trabajo.

Si cualquiera de estos checks falla, **rehacer el texto antes de persistir**.

### Paso 5 — Confirmar al Orquestador

El sub-agente confirma al orquestador que la actualización se realizó correctamente.

**No devolver el texto completo en el chat** — solo la confirmación de éxito especificando **siempre** la ubicación exacta:

- Si se usó Notion: indicar el título o URL de la página semanal.
- Si se usó Markdown local: indicar la ruta completa del archivo generado (ej: `/home/usuario/proyecto/reportes/semana-2026-04-06_a_2026-04-12/2026-04-10-jueves.md`).

---

## Herramientas Requeridas

| Herramienta | Para qué |
|---|---|
| `mem_context` / `mem_search` / `mem_get_observation` | Recuperar contexto de sesión y Engram |
| `git status` / `git diff` / `git log` | Identificar archivos modificados y commits del día |
| MCP Notion | Buscar, crear y actualizar páginas (backend preferido) |
| Escritura de archivos | Crear/archivar Markdown local (backend de fallback) |

---

## Referencias

- `shared/docs/reporte_diario_template.md` — Plantilla de reporte diario (aplica a ambos backends)
- `shared/docs/reporte_markdown_local.md` — Especificación del fallback local
- `shared/prompts/opencode/internal-weekly-report.md` — Prompt del sub-agente para OpenCode
