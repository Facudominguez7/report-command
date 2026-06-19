Genera o actualiza el reporte diario de trabajo como archivo Markdown local usando la skill `internal-weekly-report`.

## Instrucciones

- Recuperá contexto desde GitHub, Engram y archivos del repositorio.
- Buscá primero en Engram las observaciones del día.
- Mostrale al usuario las observaciones encontradas y preguntale cuáles quiere usar para el reporte antes de seguir.
- Preguntale también en qué carpeta o repositorio quiere que se ejecuten los comandos de Git/GitHub antes de correrlos.
- Preguntale **siempre** en qué carpeta quiere que se guarde el reporte. Si ya existe una carpeta `reportes/`, informale y preguntale si quiere seguir ahí o elegir otra ubicación.
- Si no existe la carpeta, confirmá la ruta completa donde se va a crear antes de escribir.
- Redactá el reporte diario con el formato establecido, aplicando las reglas estrictas de redacción (primera persona en Status, sin terminología SDD/pipeline, sin artefactos de código en Bloque 1).
- Persistí el reporte **siempre** como archivo Markdown local en la ruta confirmada: `reportes/semana-{YYYY-MM-DD}_a_{YYYY-MM-DD}/{YYYY-MM-DD-dia}.md`.
- No crees archivos diarios fuera del formato de registro semanal.
- Si falta contexto, preguntá.
- Si no hubo cambios del día, avisá.
- No muestres el texto completo del reporte en el chat.
- Al confirmar, especificá siempre la ruta completa del archivo generado.
