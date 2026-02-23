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
; SetTitleMatchMode(1)

; Omniverse Launcher
#HotIf !WinExist("ahk_exe NVIDIA Omniverse Launcher.exe")
#+o:: Run(A_Programs "/NVIDIA Corporation/NVIDIA Omniverse Launcher")
#HotIf
#HotIf !WinActive("ahk_exe NVIDIA Omniverse Launcher.exe")
#+o:: WinActivate("ahk_exe NVIDIA Omniverse Launcher.exe")

#HotIf
#HotIf WinActive("ahk_exe NVIDIA Omniverse Launcher.exe")
; #+o::WinClose()
#+o:: ProcessClose "NVIDIA Omniverse Launcher.exe"
#Escape:: ProcessClose "NVIDIA Omniverse Launcher.exe"
1:: {
    MouseGetPos &xpos, &ypos
    Click "100 50"
    MouseMove xpos, ypos
}
2:: {
    MouseGetPos &xpos, &ypos
    Click "200 50"
    MouseMove xpos, ypos
}
3:: {
    MouseGetPos &xpos, &ypos
    Click "300 50"
    MouseMove xpos, ypos
}
4:: {
    MouseGetPos &xpos, &ypos
    Click "450 50"
    MouseMove xpos, ypos
}
5:: {
    MouseGetPos &xpos, &ypos
    Click "550 50"
    MouseMove xpos, ypos
}
Escape:: {
    MouseGetPos &xpos, &ypos
    Click "300 125"
    MouseMove xpos, ypos
    Sleep 500
    ProcessClose "NVIDIA Omniverse Launcher.exe"
}
#HotIf