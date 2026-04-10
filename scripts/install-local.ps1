param()

$ErrorActionPreference = "Stop"
$raizRepo = Split-Path -Parent $PSScriptRoot

New-Item -ItemType Directory -Force -Path (Join-Path $raizRepo "reportes") | Out-Null
$env:NOTION_REPORT_HOME = $raizRepo
powershell -ExecutionPolicy Bypass -File (Join-Path $raizRepo "scripts/sync.ps1")
Write-Host "report-command enlazado desde checkout local en $raizRepo"
