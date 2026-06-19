---
name: internal-weekly-report
description: >
  Genera o actualiza el reporte diario de trabajo como archivo Markdown local,
  agrupado en una carpeta semanal. Pregunta siempre al usuario en qué carpeta
  guardar el reporte antes de escribir. Aplica reglas estrictas de redacción.
  Trigger: uso interno del comando "/report". No invocar manualmente.
license: Apache-2.0
metadata:
  author: relex
  version: "3.0.0"
---

## Cuándo Usar

Solo cuando el orquestador delega `/report`. No se invoca como comando manual de usuario.

---

## Backend

El reporte se persiste **siempre** como archivo Markdown local dentro de una carpeta semanal. No hay integración con Notion ni con ningún otro servicio externo. Antes de escribir, **SIEMPRE** preguntar al usuario en qué carpeta guardar el reporte.

---

## Guardrails Críticos

- **NUNCA** crear una página por día (solo registro semanal).
- **NUNCA** inventar estado: si falta dato, usar `pendiente de confirmación`.
- **NUNCA** mencionar proceso interno (`SDD`, `apply`, `verify`, `batch`, etc.).
- **NUNCA** mencionar cambios en `AGENTS.md`.
- **SIEMPRE** recuperar contexto en Engram antes de redactar y validar con el usuario qué observaciones usar.
- **SIEMPRE** preguntar carpeta/repo para comandos Git/GitHub antes de ejecutarlos.
- **SIEMPRE** preguntar al usuario en qué carpeta guardar el reporte y confirmar la ubicación antes de escribir.
- **SIEMPRE** confirmar la ruta completa del archivo al finalizar.
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
- Preguntar **siempre** en qué carpeta guardar el reporte; si existe `reportes/`, confirmar si seguir ahí o cambiar.
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

### Paso 4 — Persistir el Reporte en Markdown Local

Usar la carpeta confirmada por el usuario en el Paso 1.5. No escribir nada hasta tener esa confirmación.

- Si el usuario no especificó una carpeta, proponer la raíz del repositorio y confirmar antes de escribir.
- Si existe una carpeta `reportes/`, informar y confirmar si seguir ahí o cambiar.
- Crear la carpeta `{ruta_elegida}/reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/` si no existe.
- Crear `{ruta_elegida}/reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/README.md` si no existe y agregar el link del día.
- Crear o actualizar el archivo `{ruta_elegida}/reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/{YYYY-MM-DD-dia}.md`.
- Si el archivo del día ya existe, reemplazar su contenido completo.
- No modificar archivos de días anteriores.
- Usar `shared/docs/reporte_markdown_local.md` como referencia obligatoria del formato.

### Paso 4.5 — Autoverificación de Redacción (OBLIGATORIO)

Antes de escribir el archivo Markdown local, validar esta checklist:

- [ ] El **Status** está redactado en **primera persona singular**.
- [ ] El **Status** no contiene fórmulas impersonales (`se completó`, `se implementó`, `se corrigió`, etc.).
- [ ] El **Status** no contiene plural de equipo (`cerramos`, `avanzamos`, `implementamos`, etc.).
- [ ] Ningún bloque menciona `SDD`, `apply`, `verify`, `explore`, `spec`, `design`, `batch` o términos equivalentes.
- [ ] El **Bloque 1** habla de funcionalidad para usuario o equipo, no de artefactos de código.
- [ ] El **Bloque 2** describe implementación y comportamiento del módulo sin exponer el proceso interno de trabajo.

Si cualquiera de estos checks falla, **rehacer el texto antes de persistir**.

### Paso 5 — Confirmar al Orquestador

El sub-agente confirma al orquestador que la actualización se realizó correctamente.

**No devolver el texto completo en el chat** — solo la confirmación de éxito especificando **siempre** la ruta completa del archivo generado (ej: `/home/usuario/proyecto/reportes/semana-2026-04-06_a_2026-04-12/2026-04-10-jueves.md`).

---

## Herramientas Requeridas

| Herramienta | Para qué |
|---|---|
| `mem_context` / `mem_search` / `mem_get_observation` | Recuperar contexto de sesión y Engram |
| `git status` / `git diff` / `git log` | Identificar archivos modificados y commits del día |
| Escritura de archivos | Crear/actualizar el reporte Markdown local |

---

## Referencias

- `shared/docs/reporte_diario_template.md` — Plantilla de reporte diario
- `shared/docs/reporte_markdown_local.md` — Especificación del formato Markdown local
- `shared/prompts/opencode/internal-weekly-report.md` — Prompt del sub-agente para OpenCode
