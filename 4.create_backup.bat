@echo off
setlocal enabledelayedexpansion

:: Get the directory of the script
set scriptDir=%~dp0
:: Remove trailing backslash if present
set scriptDir=%scriptDir:~0,-1%

:: Define folder paths
set settingsFolder=%scriptDir%\_scripts
set archiveFolder=%scriptDir%\_backups

:: Create _archive folder if it doesn't exist
if not exist "%archiveFolder%" (
    mkdir "%archiveFolder%"
)

:: Check if the _scripts folder exists
if not exist "%settingsFolder%" (
    echo Error: The folder "_scripts" does not exist.
    pause
    exit /b
)

:: Find the highest existing backup version
set maxVersion=000
for /f "delims=" %%F in ('dir /b /a-d "%archiveFolder%\backup_*.tar" 2^>nul') do (
    for /f "tokens=2 delims=_." %%V in ("%%F") do (
        :: Compare versions as strings
        if "%%V" gtr "!maxVersion!" set maxVersion=%%V
    )
)

:: Increment version number
set /a newVersion=1%maxVersion% - 1000 + 1
set newVersion=000!newVersion!
set newVersion=!newVersion:~-3!

:: Define the name of the new backup
set backupName=backup_!newVersion!.tar
set backupPath=%archiveFolder%\%backupName%

:: Archive the _settings folder's content (files and subfolders)
echo Creating archive "%backupPath%"...
:: Create the archive using tar with -cf flag, ensuring content is included correctly
tar -cf "%backupPath%" --exclude="desktop.ini" -C "%settingsFolder%" .

:: Verify the result
if %errorlevel% equ 0 (
    echo Backup created successfully.
) else (
    echo Failed to create backup. Please check the settings.
)

pause