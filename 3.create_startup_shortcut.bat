@echo off
set "file=_run_all.ahk.lnk"
set "sourceFolder=D:\Dropbox\Configs\AutoHotkey\"
set "destinationFolder=C:\Users\Timur\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup\"

:: Display the full source and destination paths for debugging
echo Source: "%sourceFolder%%file%"
echo Destination: "%destinationFolder%%file%"

:: Check if the source file exists
if not exist "%sourceFolder%%file%" (
    echo ERROR: Source file does not exist!
    pause
    exit /b
)

:: Check if the shortcut exists in the destination folder
if exist "%destinationFolder%%file%" (
    echo Shortcut exists. Deleting the old shortcut...
    del "%destinationFolder%%file%"
)

:: Copy the shortcut from source to destination
echo Copying shortcut...
copy "%sourceFolder%%file%" "%destinationFolder%"

echo Operation complete.
pause
