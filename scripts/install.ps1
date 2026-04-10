param()

$ErrorActionPreference = "Stop"
$repo = if ($env:REPO_SSH) { $env:REPO_SSH } else { "git@github.com:relexsrl/notion-report-command.git" }
$destino = if ($env:NOTION_REPORT_HOME) { $env:NOTION_REPORT_HOME } else { Join-Path $HOME ".relex/notion-report-command" }

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
Write-Host "notion-report-command instalado en $destino"
