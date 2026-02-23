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

#HotIf WinActive(appHindie) or WinActive(appHoudini)
!Space:: Send("^+f")
^!r:: {
    Send("^!r")
    Sleep 50
    Send("^!=")
    Send("^!-")
}
#HotIf

#HotIf WinActive("Find Node")
!Space:: WinClose()
#HotIf

#HotIf WinActive("Display Options") or WinActive("Snap Options") or WinActive("Houdini Preferences") or WinActive(
    "Open") or WinActive("Save As") or WinActive("Choose") or WinActive("choose") or WinActive("Edit Group Color") or
WinActive("Aliases/Variables") or WinActive("Construction Plane Parameters") or WinActive("treecontrol") or WinActive(
    "rendergallery") or WinActive("Parameters") or WinActive("Animation Editor") or WinActive(
        "Houdini Indie Limited-Commercial - chaneditor") or WinActive(
            "Houdini Indie Limited-Commercial - Animation Editor") or WinActive("Load Color Correction LUT")
Escape:: WinClose()
#HotIf

#HotIf WinActive("Color Editor") or WinActive("Select Color") or WinActive("Aliases") or WinActive("Variables") or
WinActive("Expressions") or WinActive("treecontrol") or WinActive("Edit Parameter Interface") or WinActive("chaneditor"
) or WinActive("Animation Editor") or WinActive("Python Shell")
^+v:: {
    try WinClose("Aliases")
    try WinClose("Variables")
    try WinClose("Expressions")
}
; ^+c::   WinClose("Select Color")
^w:: WinClose("treecontrol")
!e:: WinClose("Edit Parameter Interface")
^+p:: {
    WinClose("Python Shell")
    WinActivate(appHoudini)
}
^+a:: {
    try WinClose("chaneditor")
    try WinClose("Animation Editor")
}
#HotIf

#HotIf WinExist("Houdini Console") or WinExist("Network View Display Options") or WinExist("Color Editor") or WinExist(
    "Select Color") or WinExist("Find Node") or WinExist("Aliases") or WinExist("Variables") or WinExist("Expressions") or
WinExist("Flipbook") or WinExist("treecontrol")
Escape:: WinActivateAndClose (["Houdini Console", "Network View Display Options", "Color Editor", "Select Color",
    "Find Node", "Aliases", "Variables", "Expressions", "Flipbook", "treecontrol"])
#HotIf

#HotIf WinActive(appHindie)
#HotIf WinExist("Color Editor") or WinExist("Select Color") or WinExist("Aliases") or WinExist("Variables") or WinExist(
    "Expressions") or WinExist("treecontrol") or WinExist("Edit Parameter Interface") or WinExist("chaneditor") or
WinExist("Animation Editor") or WinExist("Python Shell")
^+v:: {
    try WinActivate("Aliases")
    try WinActivate("Variables")
    try WinActivate("Expressions")
}
!e:: WinActivate("Edit Parameter Interface")
^+p:: WinActivate("Python Shell")
^+a:: {
    try WinActivate("chaneditor")
    try WinActivate("Animation Editor")
}
#HotIf
#HotIf

#HotIf WinActive("ahk_exe houdini_launcher.exe")
#Escape:: WinClose
#HotIf