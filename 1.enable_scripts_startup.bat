setlocal

set "sourceFolder=%~dp0"
set "destinationFolder=%APPDATA%\Microsoft\Windows\Start Menu\Programs\Startup"
set "shortcutName=Autohotkey.lnk"
copy /y "%sourceFolder%\%shortcutName%" "%destinationFolder%\%shortcutName%"

endlocal
