#Include "%A_ScriptDir%\_mytools\mytools_functions.ahk"
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

; Win + Backspace : Recycle Bin
#BackSpace:: Run(A_ComSpec " /c `"echo Y|PowerShell -NoProfile -Command Clear-RecycleBin`"", , "Hide")