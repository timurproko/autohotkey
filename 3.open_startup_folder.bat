@echo off
set "path=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"

REM Open the folder in File Explorer
start explorer "%path%"
