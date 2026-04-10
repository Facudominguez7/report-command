Genera o actualiza el reporte diario en la página semanal de Notion usando la skill `internal-weekly-report` y, si Notion no está disponible, hace fallback automático a Markdown local.

## Instrucciones

- Recuperá contexto desde GitHub, Engram y archivos del repositorio.
- Buscá primero en Engram las observaciones del día.
- Mostrale al usuario las observaciones encontradas y preguntale cuáles quiere usar para el reporte antes de seguir.
- Preguntale también en qué carpeta o repositorio quiere que se ejecuten los comandos de Git/GitHub antes de correrlos.
- Si el backend es Markdown local, preguntale en qué carpeta quiere que se guarden los reportes. Si ya existe una carpeta `reportes/`, informale y preguntale si quiere seguir ahí o elegir otra ubicación.
- Si no existe la carpeta, confirmá la ruta completa donde se va a crear antes de escribir.
- Redactá el reporte diario con el formato establecido, aplicando las reglas estrictas de redacción (primera persona en Status, sin terminología SDD/pipeline, sin artefactos de código en Bloque 1).
- Las reglas de redacción aplican **idénticamente** tanto para Notion como para Markdown local.
- Detectá si Notion está disponible.
- Si Notion está disponible, actualizá la página semanal vigente o creala si no existe.
- Si Notion no está disponible, preguntale al usuario dónde guardar los reportes locales y usá la ruta confirmada.
- No crees páginas diarias.
- Si falta contexto, preguntá.
- Si no hubo cambios del día, avisá.
- Si Notion falla, avisá sin romper la sesión y seguí con el fallback local.
- No muestres el texto completo del reporte en el chat.
- Al confirmar, siempre especificá la ubicación exacta: Notion (título/URL de la página) o Markdown local (ruta completa del archivo).
