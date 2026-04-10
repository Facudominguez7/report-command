# Plantilla: Reporte Diario (Notion o Markdown local)

> Archivo de referencia para la skill `internal-weekly-report`.
> Reemplazá los bloques entre `{{ }}` con el contenido real del día.
> No modificar la estructura de secciones ni el orden de los bloques.
> Esta plantilla aplica tanto para Notion como para el archivo Markdown local de fallback.
> Las reglas de redacción son IDÉNTICAS para ambos backends.

---

## {{Día}} {{DD/MM/AAAA}}

---

### Bloque 1 — Status

{{Párrafo conversacional en español rioplatense, primera persona, máximo 4-5 oraciones. DESCRIBIR FUNCIONALIDAD — lo que el usuario puede hacer ahora —, NO código escrito ni terminología técnica. Sin mencionar AGENTS.md ni términos SDD.}}

> ⚠️ **Regla absoluta**: El Bloque 1 habla de RESULTADOS de negocio, nunca de artefactos de desarrollo. Si escribiste "batch", "one2many", "ValidationError", "modelo bridge", "ACLS" o cualquier término de framework/pipeline, estás en el Bloque 2. Volvé y traducilo a funcionalidad.

**Ejemplo MALO**:

> Jornada full en SDD apply para regímenes especiales. Se completó el batch 2: 4 modelos bridge, integración base one2many en modelos padre, pestañas/listados en vistas, ACLs y tests del lote.

**Ejemplo BUENO**:

> Hoy cerramos la configuración de regímenes especiales y datos extra para partidas y parcelas — ya se pueden dar de alta y vincular desde el formulario.

---

**Resumen visual**

| Hecho | Pendiente | Dudas |
|---|---|---|
| {{Funcionalidad completada en términos de usuario}} | {{Funcionalidad que falta}} | {{Duda o limitación}} |

> Si el backend no soporta tablas de forma confiable, reemplazar por:
> - ✅ Hecho: ...
> - 🔄 Pendiente: ...
> - ❓ Dudas: ...

---

### Bloque 2 — Reporte Técnico

#### Introducción

{{Una oración que contextualiza el trabajo del día: módulo afectado, objetivo general y motivación técnica o de negocio. SIN mencionar SDD, batch, apply, verify, ni ningún término del proceso interno.}}

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

---

## Autoverificación Obligatoria (antes de publicar)

Antes de escribir en cualquier backend (Notion o Markdown local), verificar:

- [ ] El **Status** está redactado en **primera persona singular**.
- [ ] El **Status** no contiene `se completó`, `se implementó`, `se corrigió` ni otras fórmulas impersonales.
- [ ] Ningún bloque menciona `SDD`, `apply`, `verify`, `explore`, `spec`, `design`, `batch` o términos equivalentes.
- [ ] El **Bloque 1** habla de funcionalidad para usuario o equipo, no de artefactos de código.
- [ ] El **Bloque 2** describe implementación y comportamiento sin exponer el proceso interno de trabajo.

Si cualquier check falla, rehacer el texto antes de persistir.
