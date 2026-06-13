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

; ------------------------------------------------------------
; Window title groups (unique values only)
; ------------------------------------------------------------

g_CloseOnEscActive := [
    "Display Options",
    "Snap Options",
    "Houdini Preferences",
    "Open",
    "Save As",
    "Choose",
    "Edit Group Color",
    "Aliases/Variables",
    "Construction Plane Parameters",
    "treecontrol",
    "rendergallery",
    "Parameters",
    "Animation Editor",
    "Houdini Indie Limited-Commercial - chaneditor",
    "Houdini Indie Limited-Commercial - Animation Editor",
    "Load Color Correction LUT"
]

g_CloseActionsActive := [
    "Color Editor",
    "Select Color",
    "Aliases",
    "Variables",
    "Expressions",
    "treecontrol",
    "Edit Parameter Interface",
    "chaneditor",
    "Animation Editor",
    "Python Shell"
]

g_ActivateAndCloseExist := [
    "Houdini Console",
    "Network View Display Options",
    "Color Editor",
    "Select Color",
    "Find Node",
    "Aliases",
    "Variables",
    "Expressions",
    "Flipbook",
    "treecontrol"
]

g_ActivateActionsExist := [
    "Color Editor",
    "Select Color",
    "Aliases",
    "Variables",
    "Expressions",
    "treecontrol",
    "Edit Parameter Interface",
    "chaneditor",
    "Animation Editor",
    "Python Shell"
]

; ------------------------------------------------------------
; Helpers
; ------------------------------------------------------------

IsHoudiniActive() {
    global appHoudini, appHindie
    return WinActive(appHoudini) || WinActive(appHindie)
}

AnyWindowActive(titles) {
    for title in titles {
        if WinActive(title)
            return true
    }
    return false
}

AnyWindowExists(titles) {
    for title in titles {
        if WinExist(title)
            return true
    }
    return false
}

ActivateIfExists(title) {
    try {
        if WinExist(title)
            WinActivate(title)
    }
}

CloseIfExists(title) {
    try {
        if WinExist(title)
            WinClose(title)
    }
}

ActivateFirstExisting(titles) {
    for title in titles {
        if WinExist(title) {
            WinActivate(title)
            return true
        }
    }
    return false
}

CloseFirstExisting(titles) {
    for title in titles {
        if WinExist(title) {
            WinClose(title)
            return true
        }
    }
    return false
}

; ------------------------------------------------------------
; Main Houdini hotkeys
; ------------------------------------------------------------

#HotIf IsHoudiniActive()
!Space:: Send("^+f")

^!r:: {
    Send("^!r")
    Sleep 50
    Send("^!=")
    Send("^!-")
}
#HotIf

; Find Node special case
#HotIf WinActive("Find Node")
!Space:: WinClose()
#HotIf

; Esc closes currently active Houdini dialogs
#HotIf IsHoudiniActive() && AnyWindowActive(g_CloseOnEscActive)
Escape:: WinClose()
#HotIf

; Close specific active Houdini windows
#HotIf IsHoudiniActive() && AnyWindowActive(g_CloseActionsActive)

^+v:: {
    CloseIfExists("Aliases")
    CloseIfExists("Variables")
    CloseIfExists("Expressions")
}

^w:: CloseIfExists("treecontrol")

!e:: CloseIfExists("Edit Parameter Interface")

^+p:: {
    CloseIfExists("Python Shell")
    if WinExist(appHoudini)
        WinActivate(appHoudini)
    else if WinExist(appHindie)
        WinActivate(appHindie)
}

^+a:: {
    CloseIfExists("chaneditor")
    CloseIfExists("Animation Editor")
}
#HotIf

; Esc activates and closes first matching existing floating window
#HotIf IsHoudiniActive() && AnyWindowExists(g_ActivateAndCloseExist)
Escape:: WinActivateAndClose(g_ActivateAndCloseExist)
#HotIf

; Activate specific existing Houdini windows
#HotIf IsHoudiniActive() && AnyWindowExists(g_ActivateActionsExist)

^+v:: {
    ActivateIfExists("Aliases")
    ActivateIfExists("Variables")
    ActivateIfExists("Expressions")
}

!e:: ActivateIfExists("Edit Parameter Interface")

^+p:: ActivateIfExists("Python Shell")

^+a:: {
    ActivateIfExists("chaneditor")
    ActivateIfExists("Animation Editor")
}
#HotIf

#HotIf WinActive("ahk_exe houdini_launcher.exe")
#Escape:: WinClose
#HotIf