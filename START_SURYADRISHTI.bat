@echo off
title SuryaDrishti Dashboard Launcher
echo ================================================================
echo    SURYADRISHTI - SOLAR FLARE INTELLIGENCE CENTER LAUNCHER
echo ================================================================
echo.

:: 1. Kill any existing process on ports 8000, 8501, 8080 if running
echo [1/4] Checking for existing background instances...
for /f "tokens=5" %%a in ('netstat -aon ^| findstr ":8000 :8501 :8080" ^| findstr "LISTENING"') do (
    taskkill /F /PID %%a >nul 2>&1
)

:: 2. Start FastAPI Ingestion Backend (Port 8000)
echo [2/4] Starting FastAPI Ingestion Backend (Port 8000)...
start "FastAPI Backend" /min cmd /c "cd /d D:\PS15_SolarFlare\backend && ..\.venv\Scripts\python -m uvicorn data_ingest.main:app --host 127.0.0.1 --port 8000"

:: 3. Start Streamlit 2D Dashboard (Port 8501)
echo [3/4] Starting Streamlit 2D Dashboard (Port 8501)...
start "Streamlit 2D Dashboard" /min cmd /c "cd /d D:\PS15_SolarFlare\frontend\dashboard && ..\..\.venv\Scripts\streamlit run dashboard.py --server.port 8501 --server.headless true"

:: 4. Start Static HTTP Server (Port 8080)
echo [4/4] Starting 3D Globe HTTP Server (Port 8080)...
start "3D Globe Server" /min cmd /c "cd /d D:\PS15_SolarFlare\frontend && ..\.venv\Scripts\python -m http.server 8080"

:: 5. Wait for servers to initialize
echo.
echo Waiting 3 seconds for services to bind...
powershell -Command "Start-Sleep -Seconds 3" >nul 2>&1

:: 6. Open Web Dashboards in Browser via Explorer (100% reliable on Windows)
echo Opening 2D and 3D Dashboards in browser...
explorer "http://localhost:8501"
explorer "http://localhost:8080/dashboard/dashboard.html"

echo.
echo ================================================================
echo    SUCCESS! Dashboards are running at:
echo    - 2D Analytics: http://localhost:8501
echo    - 3D Globe:     http://localhost:8080/dashboard/dashboard.html
echo ================================================================
echo.
