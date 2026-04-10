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

## Fallback local a Markdown

Cuando Notion no está disponible, `/notion` debe persistir el reporte en la raíz del repo con esta estructura:

```text
reportes/
└── 2026/
    └── semana-15/
        └── 2026-04-09-jueves.md
```

Reglas del fallback:

- un archivo por día,
- agrupado por año y semana ISO,
- si el archivo del día ya existe, se reemplaza completo,
- no se modifican archivos de días anteriores.

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

## Próximos pasos sugeridos

1. Validar el comportamiento exacto del fallback Markdown sobre una instalación limpia.
2. Probar `scripts/sync.sh` y `scripts/sync.ps1` sobre una instalación limpia.
3. Completar la registración automática del hook de Claude Code.
4. Endurecer el updater para manejo de errores, lock y logs.
5. Probar el flujo en Linux y Windows con y sin Notion configurado.

## Instalación objetivo

### Linux

```bash
curl -fsSL https://raw.githubusercontent.com/relexsrl/notion-report-command/main/scripts/install.sh | bash
```

### Windows

```powershell
irm https://raw.githubusercontent.com/relexsrl/notion-report-command/main/scripts/install.ps1 | iex
```

> Nota: el repositorio es privado. El usuario debe tener acceso GitHub/SSH configurado.
# notion-report-command
