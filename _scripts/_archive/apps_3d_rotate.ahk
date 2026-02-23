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

; Gaea
#HotIf WinActive("ahk_exe Gaea.Viewport.exe")
*Space:: Send("{Alt Down}")
*Space Up:: Send("{Alt Up}")
^Space:: Send("{Space Down}")
^Space Up:: Send("{Space Up}")
#HotIf

; General
; #HotIf WinActive("RizomUV") or WinActive("Marvelous Designer") or WinActive("ahk_exe Wrap.exe") or WinActive("CLO") or WinActive("Adobe Substance") or WinActive("Marmoset Toolbag") or WinActive("ZBrush") or WinActive("Blender") or WinActive("ahk_exe kit.exe") or WinActive("ahk_exe UnrealEditor.exe")
; *Space:: Send("{Alt Down}")
; *Space Up:: Send("{Alt Up}")
; ^Space:: Send("{Space Down}")
; ^Space Up:: Send("{Space Up}")
; #HotIf
