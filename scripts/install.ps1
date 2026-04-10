param()

$ErrorActionPreference = "Stop"
$repo = if ($env:REPO_SSH) { $env:REPO_SSH } else { "git@github.com:Facudominguez7/report-command.git" }
$destino = if ($env:REPORT_COMMAND_HOME) { $env:REPORT_COMMAND_HOME } elseif ($env:NOTION_REPORT_HOME) { $env:NOTION_REPORT_HOME } else { Join-Path $HOME ".rajadeacarubio/report-command" }

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "Falta git en el sistema."
}

if (Test-Path (Join-Path $destino ".git")) {
    git -C $destino fetch --all --prune | Out-Null
    git -C $destino pull --ff-only | Out-Null
} else {
    New-Item -ItemType Directory -Force -Path (Split-Path $destino -Parent) | Out-Null
    git clone $repo $destino
}

powershell -ExecutionPolicy Bypass -File (Join-Path $destino "scripts/sync.ps1")
Write-Host "report-command instalado en $destino"
