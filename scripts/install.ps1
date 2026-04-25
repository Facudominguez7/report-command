param()

$ErrorActionPreference = "Stop"
$repoHttps = if ($env:REPO_HTTPS) { $env:REPO_HTTPS } else { "https://github.com/Facudominguez7/report-command.git" }
$repoSsh = if ($env:REPO_SSH) { $env:REPO_SSH } else { "git@github.com:Facudominguez7/report-command.git" }
$repo = if ($env:REPO_URL) { $env:REPO_URL } elseif ($env:REPO_SSH) { $repoSsh } else { $repoHttps }
$destino = if ($env:REPORT_COMMAND_HOME) { $env:REPORT_COMMAND_HOME } elseif ($env:NOTION_REPORT_HOME) { $env:NOTION_REPORT_HOME } else { Join-Path $HOME ".rajadeacarubio/report-command" }

function Invoke-Git {
    param(
        [Parameter(Mandatory = $true)]
        [string[]]$Args,
        [Parameter(Mandatory = $true)]
        [string]$ErrorMessage
    )

    & git @Args
    if ($LASTEXITCODE -ne 0) {
        throw $ErrorMessage
    }
}

if (-not (Get-Command git -ErrorAction SilentlyContinue)) {
    throw "Falta git en el sistema."
}

if (Test-Path (Join-Path $destino ".git")) {
    Invoke-Git -Args @("-C", $destino, "fetch", "--all", "--prune") -ErrorMessage "No se pudo actualizar el repositorio en $destino (fetch falló)."
    Invoke-Git -Args @("-C", $destino, "pull", "--ff-only") -ErrorMessage "No se pudo actualizar el repositorio en $destino (pull falló)."
} else {
    New-Item -ItemType Directory -Force -Path (Split-Path $destino -Parent) | Out-Null

    if ($env:REPO_URL -or $env:REPO_SSH) {
        Invoke-Git -Args @("clone", $repo, $destino) -ErrorMessage "No se pudo clonar el repositorio desde '$repo'."
    } else {
        & git clone $repoHttps $destino
        if ($LASTEXITCODE -ne 0) {
            Write-Warning "Clone por HTTPS falló. Intentando SSH..."
            Invoke-Git -Args @("clone", $repoSsh, $destino) -ErrorMessage "No se pudo clonar el repositorio ni por HTTPS ni por SSH."
        }
    }
}

$syncScript = Join-Path $destino "scripts/sync.ps1"
if (-not (Test-Path $syncScript)) {
    throw "No se encontró '$syncScript'. La instalación no se completó."
}

& powershell -ExecutionPolicy Bypass -File $syncScript
if ($LASTEXITCODE -ne 0) {
    throw "Falló la ejecución de sync.ps1."
}

Write-Host "report-command instalado en $destino"
