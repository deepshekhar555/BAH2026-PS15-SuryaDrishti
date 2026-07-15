@echo off
REM Build Docker image for 2D dashboard
docker build -t solar-dashboard -f Dockerfile.dashboard ..
if errorlevel 1 (
  echo Docker build failed.
  exit /b 1
)
REM Run container exposing port 8080 -> 80
docker run -d -p 8080:80 --name solar-dashboard-container solar-dashboard
if errorlevel 1 (
  echo Docker run failed.
  exit /b 1
)
echo Dashboard available at http://localhost:8080/dashboard_2d.html
