param(
    [string]$Destination = $(if ($env:CODEX_HOME) { Join-Path $env:CODEX_HOME 'skills' } else { Join-Path $HOME '.codex\skills' })
)

$target = Join-Path $Destination 'rnaseq-de'
New-Item -ItemType Directory -Force -Path $Destination | Out-Null
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'rnaseq-de') -Destination $target -Recurse -Force
Write-Host "Installed rnaseq-de to $target"
