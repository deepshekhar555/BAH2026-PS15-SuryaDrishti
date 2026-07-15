@echo off
echo Starting Aditya-L1 Solar Flare Dashboard...
echo.

:: 1. Start the FastAPI backend in a new command window
echo [1/3] Starting FastAPI Ingestion Backend...
start "FastAPI Ingestion Backend" cmd /k "cd /d D:\PS15_SolarFlare && python -m uvicorn data_ingest.main:app --host 127.0.0.1 --port 8000"

:: 2. Start the HTTP static file server in a new command window
echo [2/3] Starting Static HTTP Dashboard Server on port 8080...
start "Static HTTP Dashboard Server" cmd /k "cd /d D:\PS15_SolarFlare && python -m http.server 8080"

:: 3. Wait 3 seconds for both servers to warm up
echo [3/3] Waiting for servers to initialize...
timeout /t 3 /nobreak >nul

:: 4. Open the dashboard in the default web browser
echo Opening dashboard in your browser...
start "" "http://localhost:8080/dashboard/dashboard.html"

echo.
echo All processes launched successfully! Keep the backend console windows open.
echo.
pause
