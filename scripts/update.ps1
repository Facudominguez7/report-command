param(
    [switch]$Silent
)

$ErrorActionPreference = "SilentlyContinue"
$destino = if ($env:NOTION_REPORT_HOME) { $env:NOTION_REPORT_HOME } else { Join-Path $HOME ".relex/notion-report-command" }

if (-not (Test-Path (Join-Path $destino ".git"))) {
    exit 0
}

git -C $destino fetch --all --prune | Out-Null
git -C $destino pull --ff-only | Out-Null
powershell -ExecutionPolicy Bypass -File (Join-Path $destino "scripts/sync.ps1") | Out-Null

if (-not $Silent) {
    Write-Host "notion-report-command actualizado"
}
