@echo off
setlocal

:: ClickTrap Awareness - Windows Launcher
:: This script safely demonstrates how executables can be disguised as images.

:: 1. Log the execution (local only, for educational tracking)
set "LOGFILE=%~dp0..\clicktrap_execution.log"
echo [%date% %time%] ClickTrap executed by %USERNAME% on %OS% >> "%LOGFILE%"

:: 2. Display the fake Holiday Photo to maintain the illusion
if exist "%~dp0..\assets\photo.jpg" (
    start "" "%~dp0..\assets\photo.jpg"
) else if exist "%~dp0..\assets\photo.jpeg" (
    start "" "%~dp0..\assets\photo.jpeg"
)

:: 3. Run the intense PowerShell Malware Simulation
start "" /b powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "%~dp0clicktrap_windows.ps1"

endlocal
