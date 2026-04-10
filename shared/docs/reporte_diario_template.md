# Plantilla: Reporte Diario (Notion o Markdown local)

> Archivo de referencia para la skill `internal-weekly-report`.
> Reemplazá los bloques entre `{{ }}` con el contenido real del día.
> No modificar la estructura de secciones ni el orden de los bloques.
> Esta plantilla aplica tanto para Notion como para el archivo Markdown local de fallback.

---

## {{Día}} {{DD/MM/AAAA}}

---

### Bloque 1 — Status

{{Párrafo conversacional en español rioplatense, primera persona, máximo 4-5 oraciones. DESCRIBIR FUNCIONALIDAD — lo que el usuario puede hacer ahora —, NO código escrito ni terminología técnica. Sin mencionar AGENTS.md ni términos SDD.}}

> ⚠️ **Regla absoluta**: El Bloque 1 habla de RESULTADOS de negocio, nunca de artefactos de desarrollo. Si escribiste "batch", "one2many", "ValidationError", "modelo bridge", "ACLS" o cualquier término de framework/pipeline, estás en el Bloque 2. Volvé y traducilo a funcionalidad.

---

**Resumen visual**

| Hecho | Pendiente | Dudas |
|---|---|---|
| {{Funcionalidad completada en términos de usuario}} | {{Funcionalidad que falta}} | {{Duda o limitación}} |

> Si el MCP de Notion no soporta tablas de forma confiable, reemplazar por:
> - ✅ Hecho: ...
> - 🔄 Pendiente: ...
> - ❓ Dudas: ...

---

### Bloque 2 — Reporte Técnico

#### Introducción

{{Una oración que contextualiza el trabajo del día: módulo afectado, objetivo general y motivación técnica o de negocio.}}

#### Casos de uso

{{Lista de los flujos o casos cubiertos en la jornada. Usar bullets cortos.}}

#### Estructura

{{Archivos o componentes creados o modificados. Solo los relevantes — sin inventarios de carpetas.}}

#### Comportamiento

{{Descripción de la lógica implementada: validaciones, flujos condicionales, métodos clave.}}

#### Dudas abiertas

{{Preguntas sin resolver, decisiones técnicas pendientes, o aclaraciones que necesitás de otra persona.}}

Si no hay dudas abiertas: `Sin dudas abiertas al cierre del día.`

---

**Commit sugerido**

```text
[ADD] relex_modulo: descripción corta
```
