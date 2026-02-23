#Include D:\Dropbox\Configs\AutoHotkey\_scripts\_mytools\mytools_functions.ahk
#Requires AutoHotkey >=v2.0
#NoTrayIcon
#SingleInstance Force
KeyHistory(0)
ListLines(false)
ProcessSetPriority("A")
SetWinDelay (-1)
SetKeyDelay (-1, -1, -1)
SetMouseDelay (-1)
SetControlDelay (-1)
RunAsAdmin()
A_HotkeyInterval := 0

; Oculus
+#q:: Run("cmd.exe /c D:\Dropbox\Configs\windows\Configs\_scripts\stop_ovr_service.bat", "", "runas Hide")

; Windows Recycle Bin
#BackSpace:: Run(A_ComSpec " /c `"echo Y|PowerShell -NoProfile -Command Clear-RecycleBin`"", , "Hide")