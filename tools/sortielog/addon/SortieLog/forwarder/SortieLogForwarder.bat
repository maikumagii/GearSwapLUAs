@echo off
rem Starts the SortieLog forwarder. Settings live in forwarder.json next to this file.
powershell -NoProfile -ExecutionPolicy Bypass -File "%~dp0SortieLogForwarder.ps1" %*
pause
