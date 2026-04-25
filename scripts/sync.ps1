param()

$ErrorActionPreference = "Stop"
$raiz = if ($env:REPORT_COMMAND_HOME) { $env:REPORT_COMMAND_HOME } elseif ($env:NOTION_REPORT_HOME) { $env:NOTION_REPORT_HOME } else { Join-Path $HOME ".rajadeacarubio/report-command" }

function Copiar-ArchivoAdministrado {
    param(
        [string]$Origen,
        [string]$Destino
    )

    New-Item -ItemType Directory -Force -Path (Split-Path $Destino -Parent) | Out-Null
    Copy-Item -Force -Path $Origen -Destination $Destino
}

# Limpiar archivos obsoletos de versiones anteriores
Write-Host "Limpiando archivos obsoletos de versiones anteriores..."
# Comandos viejos (notion.md en lugar de report.md)
Remove-Item -Force -ErrorAction SilentlyContinue (Join-Path $HOME ".claude/commands/notion.md")
Remove-Item -Force -ErrorAction SilentlyContinue (Join-Path $HOME ".config/opencode/commands/notion.md")
# Skills viejas (nombres anteriores a internal-weekly-report)
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue (Join-Path $HOME ".claude/skills/report-weekly-report")
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue (Join-Path $HOME ".config/opencode/skills/report-weekly-report")
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue (Join-Path $HOME ".config/opencode/skills/notion-weekly-report")
# OpenCode ya no instala la skill internal-weekly-report (solo /report)
Remove-Item -Recurse -Force -ErrorAction SilentlyContinue (Join-Path $HOME ".config/opencode/skills/internal-weekly-report")
Write-Host "Limpieza completada."

Copiar-ArchivoAdministrado (Join-Path $raiz "adapters/claude/commands/report.md") (Join-Path $HOME ".claude/commands/report.md")
Copiar-ArchivoAdministrado (Join-Path $raiz "shared/skills/internal-weekly-report/SKILL.md") (Join-Path $HOME ".claude/skills/internal-weekly-report/SKILL.md")
Copiar-ArchivoAdministrado (Join-Path $raiz "adapters/opencode/commands/report.md") (Join-Path $HOME ".config/opencode/commands/report.md")
Copiar-ArchivoAdministrado (Join-Path $raiz "adapters/opencode/plugins/report-auto-update.js") (Join-Path $HOME ".config/opencode/plugins/report-auto-update.js")
