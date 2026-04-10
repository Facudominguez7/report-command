---
name: notion-weekly-report
description: >
  Genera o actualiza el reporte diario en la página semanal de Notion y, si Notion no está disponible, lo guarda en Markdown local.
  Trigger: cuando el usuario escriba el comando "/notion".
license: Apache-2.0
metadata:
  author: relex
  version: "0.2.0"
---

## Cuándo usar

Únicamente cuando el usuario escribe el comando explícito `/notion`.

## Objetivo

Crear o actualizar la entrada del día usando un backend dual:

- **Backend preferido**: página semanal de Notion usando MCP.
- **Backend de fallback**: archivo Markdown local dentro del repositorio cuando Notion no está disponible o no está configurado.

## Reglas críticas

- **NUNCA** crear una página por día.
- **SIEMPRE** trabajar sobre una página semanal; si no existe, crearla.
- **SIEMPRE** intentar Notion primero y, si no está disponible, hacer fallback automático a Markdown local.
- **SIEMPRE** guardar el fallback local dentro de `reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/` en la raíz del repositorio.
- **SIEMPRE** crear `README.md` semanal si no existe y agregar allí el link al día generado.
- **NUNCA** inventar estado ni asumir trabajo no confirmado.
- **SIEMPRE** preguntar si falta contexto.
- **SIEMPRE** avisar si no hubo cambios relevantes en el día.
- **SIEMPRE** avisar si falla Notion, sin romper la sesión y continuar con Markdown local si corresponde.
- **NUNCA** mostrar el texto completo del reporte en el chat.
- **NUNCA** mencionar SDD, pipeline, batch, apply, propose, verify, explore, spec ni design en ningún bloque.

## Workflow obligatorio

1. Recuperar contexto del día desde GitHub, Engram y archivos del repo.
2. Redactar la entrada diaria con el formato establecido en la plantilla.
3. Detectar si Notion está disponible en la sesión actual.
4. Si Notion está disponible, buscar la página semanal vigente y crearla si no existe.
5. Si Notion no está disponible, crear o actualizar el archivo local `reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/{YYYY-MM-DD-dia}.md` y asegurar `reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/README.md`.
6. Confirmar éxito indicando el destino usado, sin devolver el texto completo.

## Referencias

- `shared/docs/notion_reporte_diario_template.md`
- `shared/docs/reporte_markdown_local.md`
- `shared/prompts/opencode/notion-weekly-report.md`
- `reportes/`
