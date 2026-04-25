Generá o actualizá el reporte diario delegando el workflow completo a la skill `internal-weekly-report`.

## Guardrails mínimos

- Seguí la skill como fuente única de workflow y formato.
- Intentá Notion primero; si no está disponible, fallback a Markdown local sin romper la sesión.
- El **Status (Bloque 1)** debe ser conversacional en **primera persona singular** (sin impersonales ni plural de equipo).
- No mencionar términos del proceso interno (SDD, apply, verify, batch, etc.).
- No mostrar el texto completo del reporte en chat; confirmar solo éxito y ubicación exacta (Notion o ruta completa de archivo).
