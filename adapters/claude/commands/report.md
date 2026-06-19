Generá o actualizá el reporte diario delegando el workflow completo a la skill `internal-weekly-report`.

## Guardrails mínimos

- Seguí la skill como fuente única de workflow y formato.
- Persistí el reporte siempre como archivo Markdown local; preguntá siempre en qué carpeta guardarlo antes de escribir.
- El **Status (Bloque 1)** debe ser conversacional en **primera persona singular** (sin impersonales ni plural de equipo).
- No mencionar términos del proceso interno (SDD, apply, verify, batch, etc.).
- No mostrar el texto completo del reporte en chat; confirmar solo éxito y la ruta completa del archivo generado.
