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

Solo cuando el orquestador delega `/report`. No se invoca como comando manual de usuario.

---

## Backend Dual

- **Backend preferido**: página semanal de Notion usando MCP.
- **Backend de fallback**: archivo Markdown local dentro del repositorio cuando Notion no está disponible o no está configurado.

Las reglas de redacción aplican **idénticamente** en ambos backends.

---

## Guardrails Críticos

- **NUNCA** crear una página por día (solo registro semanal).
- **NUNCA** inventar estado: si falta dato, usar `pendiente de confirmación`.
- **NUNCA** mencionar proceso interno (`SDD`, `apply`, `verify`, `batch`, etc.).
- **NUNCA** mencionar cambios en `AGENTS.md`.
- **SIEMPRE** recuperar contexto en Engram antes de redactar y validar con el usuario qué observaciones usar.
- **SIEMPRE** preguntar carpeta/repo para comandos Git/GitHub antes de ejecutarlos.
- **SIEMPRE** intentar Notion primero; si falla, fallback automático a Markdown local.
- **SIEMPRE** confirmar ubicación exacta al finalizar (página Notion o ruta completa del archivo).
- **NUNCA** mostrar el texto completo del reporte en el chat.

### Bloque 1 (Status): humanización obligatoria

El Status es **conversacional** y en **primera persona singular**.

- **SIEMPRE** usar verbos como: `terminé`, `avancé`, `corregí`, `me quedó`, `estoy revisando`.
- **NUNCA** usar frases impersonales/pasivas: `se completó`, `se implementó`, `se corrigió`, `se avanzó`.
- **NUNCA** usar plural inclusivo: `cerramos`, `avanzamos`, `implementamos`, `corregimos`.
- Si suena a changelog técnico en vez de mensaje humano, está mal: reescribir.

### Bloque 1 (Status): foco funcional

- Describir **qué puede hacer ahora el usuario/equipo** gracias a lo hecho hoy.
- Incluir solo: **Hecho**, **Pendiente**, **Dudas/Bloqueos** (si existen).
- No listar artefactos técnicos como logros (modelos, vistas, ACLs, tests, rutas, errores internos).

### Bloque 2 (Reporte Técnico): límites

- Puede ser técnico, pero **sin** terminología del proceso interno.
- Priorizar implementación, estructura y comportamiento del módulo.
- Cerrar con propuesta de nombre de commit estilo Odoo.


---

## Delegación: Sub-Agente Efímero (OBLIGATORIO)

Esta tarea se delega SIEMPRE a un sub-agente efímero para aislar el contexto de la sesión principal. El orquestador no ejecuta los pasos directamente.

---

## Workflow del Sub-Agente (6 Pasos Exactos)

### Paso 1 — Recuperar Contexto del Día

1. `mem_context`.
2. `mem_search` + `mem_get_observation` con keywords del día (incluyendo módulos detectados).
3. Listar observaciones candidatas.
4. **Preguntar al usuario cuáles usar**.

No redactar ni persistir hasta que el usuario responda.

### Paso 1.5 — Confirmar Carpetas de Trabajo

- Preguntar carpeta/repo para comandos Git/GitHub.
- Si backend Markdown: preguntar carpeta de guardado; si existe `reportes/`, confirmar si seguir ahí o cambiar.
- Esperar respuesta antes de continuar.

### Paso 2 — Relevamiento Complementario

1. `git status` + `git diff --name-only HEAD` + `git branch` + `git log --oneline --since=today`
2. De la salida de git, extraer: nombre(s) de módulo, entidades de negocio afectadas y usarlas como keywords en `mem_search`
3. Recuperar dudas, consultas o limitaciones técnicas pendientes

### Paso 3 — Redactar la Entrada Diaria

Layout **fijo y obligatorio** con exactamente DOS bloques en este orden:

#### Bloque 1 — Status (conversacional)

- **Tono**: español rioplatense, breve, primera persona singular.
- **Contenido** (en orden):
  1. **Qué funcionalidad se completó hoy** — en términos de lo que el usuario puede hacer ahora (no código escrito).
  2. **Qué queda pendiente** — en términos de funcionalidad que falta, no de tareas técnicas.
  3. **Dudas o bloqueos** — si los hay; si no, simplemente no los mencionás.
- **Presentación visual**: tabla simple corta con columnas `Hecho | Pendiente | Dudas` si el backend lo soporta; si no, lista compacta con ✅ 🔄 ❓.
- **Chequeo obligatorio**: releer y confirmar que no haya impersonales ni plural (`cerramos`, `avanzamos`, etc.).

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
- Si existe una carpeta `reportes/`, informar y confirmar si seguir ahí o cambiar.
- Crear la carpeta `{ruta_elegida}/reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/` si no existe.
- Crear `{ruta_elegida}/reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/README.md` si no existe y agregar el link del día.
- Crear o actualizar el archivo `{ruta_elegida}/reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/{YYYY-MM-DD-dia}.md`.
- Si el archivo del día ya existe, reemplazar su contenido completo.
- No modificar archivos de días anteriores.
- Usar `shared/docs/reporte_markdown_local.md` como referencia obligatoria del formato.

### Paso 4.5 — Autoverificación de Redacción (OBLIGATORIO)

Antes de escribir en cualquier backend (Notion o Markdown local), validar esta checklist:

- [ ] El **Status** está redactado en **primera persona singular**.
- [ ] El **Status** no contiene fórmulas impersonales (`se completó`, `se implementó`, `se corrigió`, etc.).
- [ ] El **Status** no contiene plural de equipo (`cerramos`, `avanzamos`, `implementamos`, etc.).
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
