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
A_HotkeyInterval := 0

; Reallusion
characterCreator := "ahk_exe CharacterCreator.exe"
iClone := "ahk_exe iClone.exe"

#HotIf WinActive(characterCreator) and NotClassNN("Edit1") or WinActive(iClone) and NotClassNN("Edit1")
    *Space::    Send("{Alt Down}")
    *Space Up:: Send("{Alt Up}")
#HotIf
#HotIf WinActive("Morph Slider Editor")
    Space::     Send("{Space}")
#HotIf
#HotIf WinActive(characterCreator) and NotClassNN("Edit1")
    ^,::        Send("^p")
    ^.::        Send("^+p")
    ^p::        Send("{f6}")
    Up::        Send("{Space}")
    h::         Send("{Home}")
    +Left::     Send(",")
    +Right::    Send(".")
    F11::       Toggle("^6", "^3")
#HotIf
#HotIf WinActive(iClone)
    Up::        Send("{Space}")
    F11::       Toggle("^7", "^2")
#HotIf

; ; Faceform Wrap
; #HotIf WinActive("ahk_exe Wrap.exe")
;     ^,:: Send("^p")
; #HotIf

; ; Omniverse
; #HotIf WinActive("ahk_exe kit.exe")
;     Tab:: return
; #HotIf

; ; RizomUV
; #HotIf WinActive("ahk_exe rizomuv.exe") and WinActive("Preferences") or WinActive("Keyboard and Mouse Customizer Dialog")
;     Escape::    WinClose()
; #HotIf

; #HotIf WinActive("ahk_exe rizomuv.exe") and WinActive("Script and Log Window")
;     Escape::    WinClose()
;     L::         WinClose()
; #HotIf