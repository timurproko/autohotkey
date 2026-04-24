@echo off
setlocal enabledelayedexpansion

:: Get the directory of the script
set scriptDir=%~dp0
:: Remove trailing backslash if present
set scriptDir=%scriptDir:~0,-1%

:: Define folder paths
set settingsFolder=%scriptDir%\_scripts
set archiveFolder=%scriptDir%\_backups

:: Check if the _scripts folder exists
if not exist "%settingsFolder%" (
    echo Error: The folder "_scripts" does not exist.
    pause
    exit /b
)

:: Ask the user for the backup version number (XXX)
set /p version="Enter the backup version (e.g., 001, 002, ...): "

:: If the version is empty, find the latest version available in the archive folder
if "%version%"=="" (
    set maxVersion=0
    for /f "delims=" %%F in ('dir /b /a-d "%archiveFolder%\backup_*.tar"') do (
        for /f "tokens=2 delims=_." %%V in ("%%F") do (
            if %%V gtr !maxVersion! set maxVersion=%%V
        )
    )
    set version=!maxVersion!
    if "!version!"=="0" (
        echo Error: No backup files found in the archive folder.
        pause
        exit /b
    )
    echo No version entered. Using the latest version: !version!
)

:: Define the corresponding backup file
set backupFile=%archiveFolder%\backup_!version!.tar

:: Check if the backup file exists
if not exist "%backupFile%" (
    echo Error: Backup file "backup_!version!.tar" not found.
    pause
    exit /b
)

:: Confirm the restore action
echo You are about to restore from the backup "%backupFile%" to "%settingsFolder%".
set /p confirm="Are you sure you want to continue? (Y/N): "

if /i "!confirm!" neq "Y" (
    echo Restore action canceled.
    pause
    exit /b
)

:: Remove all existing files and folders in the _scripts folder
echo Deleting existing files and folders in "_scripts"... 
rd /s /q "%settingsFolder%" 2>nul

:: Recreate the _scripts folder
mkdir "%settingsFolder%" 2>nul

:: Extract the backup TAR file to the _scripts folder
echo Restoring from the backup "%backupFile%"...
tar -xf "%backupFile%" -C "%settingsFolder%"

:: Verify the result
if %errorlevel% equ 0 (
    echo Restore completed successfully.
) else (
    echo Failed to restore the backup. Please check the settings and try again.
)

pause