@echo off
REM Script to generate all Swift/WinRT bindings from split .rsp files

setlocal enabledelayedexpansion

set SWIFTWINRT=out\debug\bin\swiftwinrt.exe
set ERROR=0

echo Generating Swift/WinRT bindings from all .rsp files...
echo.

if not exist "%SWIFTWINRT%" (
    echo Error: %SWIFTWINRT% not found!
    exit /b 1
)

for %%f in (WinUI.rsp WindowsAppSDK.rsp cwinrt.rsp WindowsFoundation.rsp) do (
    if not exist "%%f" (
        echo Error: %%f not found!
        exit /b 1
    )
    
    echo Processing %%f...
    "%SWIFTWINRT%" "@%%f"
    
    if errorlevel 1 (
        echo Error: Failed to process %%f
        set ERROR=1
        goto :end
    )
    
    echo Successfully processed %%f
    echo.
)

:end
if %ERROR%==0 (
    echo All bindings generated successfully!
) else (
    echo One or more bindings failed to generate.
    exit /b 1
)


