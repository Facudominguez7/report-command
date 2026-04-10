# notion-report-command

Distribución compartida del comando `/notion` para **Claude Code** y **OpenCode**.

## Propósito

Este repositorio concentra una única fuente de verdad para:

- el comando `/notion`,
- la skill `notion-weekly-report`,
- los adaptadores para Claude Code y OpenCode,
- los scripts de instalación y actualización automática.

El comando usa una estrategia de **backend dual**:

- **Preferido**: actualiza la página semanal en Notion cuando el MCP está disponible.
- **Fallback**: genera un archivo Markdown local dentro de `reportes/` cuando Notion no está configurado o no responde.

La meta es que cualquier integrante del equipo pueda instalarlo con **un solo comando** y obtener el mismo comportamiento funcional validado en la máquina de referencia, sin quedar bloqueado si todavía no configuró Notion.

## Alcance del scaffold

Este scaffold ya incluye:

- estructura inicial del repo,
- skill compartida base,
- comandos base para Claude y OpenCode,
- prompt base de sub-agente para OpenCode,
- scripts iniciales de `install`, `update` y `sync`,
- configuración base para auto-update en ambas herramientas.

Además incluye instalación desde checkout local para usar la herramienta antes de publicarla como repositorio independiente.

## Fallback local a Markdown

Cuando Notion no está disponible, `/notion` debe persistir el reporte en la raíz del repo con esta estructura:

```text
reportes/
└── semana-2026-04-06_a_2026-04-12/
    └── 2026-04-09-jueves.md
```

Reglas del fallback:

- un archivo por día,
- agrupado por carpeta semanal con rango fecha a fecha,
- un `README.md` por semana con links a los días cargados,
- si el archivo del día ya existe, se reemplaza completo,
- no se modifican archivos de días anteriores.

Formato de ejemplo:

```text
reportes/
└── semana-2026-04-06_a_2026-04-12/
    ├── README.md
    └── 2026-04-09-jueves.md
```

La especificación del formato local quedó documentada en:

- `shared/docs/reporte_markdown_local.md`

## Estructura

```text
notion-report-command/
├── adapters/
│   ├── claude/
│   └── opencode/
├── reportes/
├── manifests/
├── scripts/
├── shared/
│   ├── commands/
│   ├── docs/
│   ├── prompts/
│   └── skills/
├── CHANGELOG.md
├── README.md
└── .gitignore
```

## Instalación

Ver guía completa en `docs/instalacion.md`.

## Instalación inmediata mientras no esté publicada

Si todavía no subiste `notion-report-command` a GitHub como repo propio, podés instalarlo desde el checkout local actual.

### Linux

```bash
bash scripts/install-local.sh
```

### Windows

```powershell
powershell -ExecutionPolicy Bypass -File .\scripts\install-local.ps1
```

Esto sincroniza `/notion` en Claude/OpenCode y deja preparada la carpeta `reportes/` para el fallback Markdown.

## Instalación objetivo cuando esté publicada

### Linux

```bash
curl -fsSL https://raw.githubusercontent.com/relexsrl/notion-report-command/main/scripts/install.sh | bash
```

### Windows

```powershell
irm https://raw.githubusercontent.com/relexsrl/notion-report-command/main/scripts/install.ps1 | iex
```

> Nota: el repositorio es privado. El usuario debe tener acceso GitHub/SSH configurado.
