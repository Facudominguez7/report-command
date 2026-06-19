# Changelog

## 1.0.0

- **BREAKING:** Eliminada la integración con Notion. El reporte se persiste siempre como archivo Markdown local.
- `/report` pregunta siempre en qué carpeta guardar el reporte antes de escribir.
- Removida la lógica de backend dual y la detección de Notion en skill, comando, prompt de OpenCode y adaptadores.

## 0.2.0

- Agregado fallback automático a Markdown local cuando Notion no está disponible.
- Definida estructura semanal `semana-fecha_a_fecha` con `README.md` y archivo diario.
- Agregadas guías y scripts de instalación desde checkout local.

## 0.1.0

- Scaffold inicial del repositorio.
- Skill compartida `internal-weekly-report`.
- Comandos base para Claude Code y OpenCode.
- Scripts iniciales de instalación, sincronización y actualización.
