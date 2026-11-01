<#
.SYNOPSIS
    FileRecova Windows 11 Build Script
.DESCRIPTION
    Builds the production frontend bundle, Windows 11 desktop GUI executable,
    and CLI forensic utility for FileRecova.
#>

[CmdletBinding()]
param (
    [string]$OutputDir = ""
)

$ErrorActionPreference = "Stop"

if ([string]::IsNullOrWhiteSpace($OutputDir)) {
    $OutputDir = Join-Path $PSScriptRoot "bin"
}

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "         FileRecova Windows 11 Build Pipeline             " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# 1. Locate Go compiler
$goCmd = Get-Command "go" -ErrorAction SilentlyContinue
if (-not $goCmd -and (Test-Path "D:\tools\go\bin\go.exe")) {
    $env:PATH = "D:\tools\go\bin;" + $env:PATH
    $goCmd = Get-Command "go" -ErrorAction SilentlyContinue
}
if (-not $goCmd) {
    Write-Error "Go compiler ('go') not found in PATH or D:\tools\go\bin. Please install Go 1.21+."
}
Write-Host "-> Using Go: $(go version)" -ForegroundColor Green

# 2. Locate Node and npm
$npmCmd = Get-Command "npm" -ErrorAction SilentlyContinue
if (-not $npmCmd -and (Test-Path "D:\tools\node-v22.14.0-win-x64\npm.cmd")) {
    $env:PATH = "D:\tools\node-v22.14.0-win-x64;" + $env:PATH
    $npmCmd = Get-Command "npm.cmd" -ErrorAction SilentlyContinue
}
if (-not $npmCmd) {
    Write-Error "npm not found in PATH or D:\tools. Please install Node.js 18+."
}
Write-Host "-> Using Node: $(node -v)" -ForegroundColor Green

# 3. Ensure Output directory
if (-not (Test-Path $OutputDir)) {
    New-Item -ItemType Directory -Path $OutputDir | Out-Null
}

# 4. Build Frontend
Write-Host ""
Write-Host "[1/3] Building Frontend Production Assets..." -ForegroundColor Yellow
Push-Location "$PSScriptRoot\frontend"
try {
    if (-not (Test-Path "node_modules")) {
        Write-Host "-> Installing frontend dependencies..." -ForegroundColor Gray
        & $npmCmd install
    }
    Write-Host "-> Bundling with Vite..." -ForegroundColor Gray
    & $npmCmd run build
}
finally {
    Pop-Location
}

if (-not (Test-Path "$PSScriptRoot\frontend\dist\index.html")) {
    Write-Error "Frontend build failed: frontend\dist\index.html not found."
}
Write-Host "[OK] Frontend built successfully into frontend\dist" -ForegroundColor Green

# 5. Build Windows 11 GUI Executable
Write-Host ""
Write-Host "[2/3] Compiling FileRecova Windows GUI Executable..." -ForegroundColor Yellow
$guiOut = Join-Path $OutputDir "FileRecovaGUI.exe"
go build -tags desktop,production -ldflags "-H windowsgui -s -w" -o $guiOut "$PSScriptRoot"

if (-not (Test-Path $guiOut)) {
    Write-Error "GUI build failed: $guiOut not generated."
}
$guiLen = (Get-Item $guiOut).Length / 1MB
Write-Host ("[OK] GUI executable built: {0} ({1:N2} MB)" -f $guiOut, $guiLen) -ForegroundColor Green

# 6. Build CLI Executable
Write-Host ""
Write-Host "[3/3] Compiling FileRecova CLI Utility..." -ForegroundColor Yellow
$cliOut = Join-Path $OutputDir "FileRecovaCLI.exe"
go build -ldflags "-s -w" -o $cliOut "$PSScriptRoot\cmd\main.go"

if (-not (Test-Path $cliOut)) {
    Write-Error "CLI build failed: $cliOut not generated."
}
$cliLen = (Get-Item $cliOut).Length / 1MB
Write-Host ("[OK] CLI executable built: {0} ({1:N2} MB)" -f $cliOut, $cliLen) -ForegroundColor Green

Write-Host ""
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "           Build Process Completed Successfully!          " -ForegroundColor Green
Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "Binaries generated in: $OutputDir"
Write-Host "  - FileRecovaGUI.exe (Windows 11 Desktop GUI)"
Write-Host "  - FileRecovaCLI.exe (Forensic Terminal Utility)"
