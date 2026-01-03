# Script to generate all Swift/WinRT bindings from split .rsp files

$ErrorActionPreference = "Stop"

$swiftwinrt = "out\debug\bin\swiftwinrt.exe"
$rspFiles = @(
    "WinUI.rsp",
    "WindowsAppSDK.rsp",
    "cwinrt.rsp",
    "WindowsFoundation.rsp"
)

Write-Host "Generating Swift/WinRT bindings from all .rsp files..." -ForegroundColor Cyan
Write-Host ""

foreach ($rspFile in $rspFiles) {
    if (-not (Test-Path $rspFile)) {
        Write-Host "Error: $rspFile not found!" -ForegroundColor Red
        exit 1
    }
    
    Write-Host "Processing $rspFile..." -ForegroundColor Yellow
    $rspPath = "@$rspFile"
    
    & $swiftwinrt $rspPath
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "Error: Failed to process $rspFile (exit code: $LASTEXITCODE)" -ForegroundColor Red
        exit $LASTEXITCODE
    }
    
    Write-Host "Successfully processed $rspFile" -ForegroundColor Green
    Write-Host ""
}

Write-Host "All bindings generated successfully!" -ForegroundColor Green


