# report-command

Distribución compartida del comando `/report` para **Claude Code** y **OpenCode**.

## Propósito

Este repositorio concentra una única fuente de verdad para:

- el comando `/report`,
- la skill interna `internal-weekly-report`,
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

Cuando Notion no está disponible, `/report` debe persistir el reporte en la raíz del repo con esta estructura:

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
report-command/
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

## Requisitos para que `/report` funcione

### Requisitos mínimos

- **Git instalado** (requerido por los scripts `install`/`update`).
- **Acceso a GitHub** para descargar/actualizar el repositorio (`raw.githubusercontent.com` y `github.com`).
- **Uno de estos clientes instalado**:
  - **Claude Code** (usa `~/.claude/commands/report.md` y su skill interna), o
  - **OpenCode** (usa `~/.config/opencode/commands/report.md` + plugin).
- **Permisos de escritura** en el home del usuario para que los scripts sincronicen archivos.

### Requisitos por sistema operativo

- **Linux/macOS**:
  - `bash`
  - `curl` (si instalás con one-liner)
- **Windows**:
  - **PowerShell 5.1+**
  - `git` en `PATH`
  - política de ejecución que permita correr el script (el instalador usa `-ExecutionPolicy Bypass`)

### Requisito opcional (Notion)

- Si querés persistir en Notion, necesitás MCP de Notion configurado en tu cliente.
- Si Notion no está disponible, `/report` funciona igual usando fallback local en `reportes/`.

### Linux

```bash
curl -fsSL https://raw.githubusercontent.com/Facudominguez7/report-command/main/scripts/install.sh | bash
```

### Windows

```powershell
irm https://raw.githubusercontent.com/Facudominguez7/report-command/main/scripts/install.ps1 | iex
```

> Nota: el repositorio es público. Solo necesitás `git` y acceso a GitHub para descargarlo.
