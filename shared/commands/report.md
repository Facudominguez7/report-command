Genera o actualiza el reporte diario en la página semanal de Notion usando la skill `internal-weekly-report` y, si Notion no está disponible, hace fallback automático a Markdown local.

## Instrucciones

- Recuperá contexto desde GitHub, Engram y archivos del repositorio.
- Buscá primero en Engram las observaciones del día.
- Mostrale al usuario las observaciones encontradas y preguntale cuáles quiere usar para el reporte antes de seguir.
- Preguntale también en qué carpeta o repositorio quiere que se ejecuten los comandos de Git/GitHub antes de correrlos.
- Redactá el reporte diario con el formato establecido.
- Detectá si Notion está disponible.
- Si Notion está disponible, actualizá la página semanal vigente o creala si no existe.
- Si Notion no está disponible, guardá el reporte en `reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/{YYYY-MM-DD-dia}.md` dentro del repo.
- No crees páginas diarias.
- Si falta contexto, preguntá.
- Si no hubo cambios del día, avisá.
- Si Notion falla, avisá sin romper la sesión y seguí con el fallback local.
- No muestres el texto completo del reporte en el chat.
