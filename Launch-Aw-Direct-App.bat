@echo off
title Launching Aw Marketplace App...
echo ========================================================
echo    Starting Aw - Freelance Marketplace (Direct App)
echo ========================================================
echo.

cd /d "%~dp0"

echo [1/3] Starting Aw Backend API Server...
start "Aw Backend" /min cmd /c "cd /d "%~dp0backend" && npm run dev"

echo [2/3] Starting Aw Frontend Web Engine...
start "Aw Frontend" /min cmd /c "cd /d "%~dp0frontend" && npm run dev"

echo [3/3] Waiting for servers to initialize...
timeout /t 3 /nobreak >nul

echo.
echo Launching Aw in Direct Standalone App Window...

:: Try Edge in App Mode (Installed by default on all Windows 10/11)
where msedge >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    start msedge --app=http://localhost:5173
    exit /b 0
)

:: Try Chrome in App Mode
where chrome >nul 2>nul
if %ERRORLEVEL% EQU 0 (
    start chrome --app=http://localhost:5173
    exit /b 0
)

:: Fallback to default browser
start http://localhost:5173
exit /b 0
