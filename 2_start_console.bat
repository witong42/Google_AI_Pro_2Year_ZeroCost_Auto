@echo off
chcp 65001 >nul
title Google AI Pro (5 TB) Zero-Cost 2-Year Full-Auto Console
cd /d "%~dp0"
echo ======================================================================
echo   Starting the Google AI Pro (5 TB) zero-cost 2-year full-auto console...
echo   Console URL: http://127.0.0.1:8765
echo ======================================================================
start "" "http://127.0.0.1:8765"
python app.py
pause
