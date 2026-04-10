param()

$ErrorActionPreference = "Stop"
$raiz = if ($env:NOTION_REPORT_HOME) { $env:NOTION_REPORT_HOME } else { Join-Path $HOME ".relex/notion-report-command" }

function Copiar-ArchivoAdministrado {
    param(
        [string]$Origen,
        [string]$Destino
    )

    New-Item -ItemType Directory -Force -Path (Split-Path $Destino -Parent) | Out-Null
    Copy-Item -Force -Path $Origen -Destination $Destino
}

Copiar-ArchivoAdministrado (Join-Path $raiz "adapters/claude/commands/notion.md") (Join-Path $HOME ".claude/commands/notion.md")
Copiar-ArchivoAdministrado (Join-Path $raiz "shared/skills/notion-weekly-report/SKILL.md") (Join-Path $HOME ".claude/skills/notion-weekly-report/SKILL.md")
Copiar-ArchivoAdministrado (Join-Path $raiz "adapters/opencode/commands/notion.md") (Join-Path $HOME ".config/opencode/commands/notion.md")
Copiar-ArchivoAdministrado (Join-Path $raiz "shared/skills/notion-weekly-report/SKILL.md") (Join-Path $HOME ".config/opencode/skills/notion-weekly-report/SKILL.md")
Copiar-ArchivoAdministrado (Join-Path $raiz "adapters/opencode/plugins/notion-auto-update.js") (Join-Path $HOME ".config/opencode/plugins/notion-auto-update.js")
