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
SetTitleMatchMode (1)
A_HotkeyInterval := 0

UnityMainWindow := "Unity"

; XR Mode
#HotIf WinActive(appOculus)
Space:: {
    ClickAtPosition("10px", "325px")
    if WinExist("ahk_exe Unity.exe") {
        if (WinActive("ahk_exe Unity.exe")) {
            Send("^!+p")
            Send("^+2")
        } else {
            WinActivate("ahk_exe Unity.exe")
            Send("^!+p")
            Send("^+2")
        }
    }
    else {
        WinActivate(appOculus)
    }
}
#HotIf

; Unity Hub
#HotIf WinActive(appUnityHub)
1:: ClickAtPosition("50%%", "320px")
2:: ClickAtPosition("50%%", "410px")
3:: ClickAtPosition("50%%", "480px")
4:: ClickAtPosition("50%%", "570px")
5:: ClickAtPosition("50%%", "660px")
6:: ClickAtPosition("50%%", "750px")
7:: ClickAtPosition("50%%", "840px")
8:: ClickAtPosition("50%%", "930px")
9:: ClickAtPosition("50%%", "1020px")
0:: ClickAtPosition("50%%", "1110px")
#HotIf

; Unity Editor
#HotIf WinActive(appUnity)
^+z:: Send("^y")
F8:: Send("!p")
+F8:: Send("!+p")
^F1:: {
    Send("^s")
    Sleep 10
    Send("^{F1}")
}
^F2:: {
    Send("^s")
    Sleep 10
    Send("^{F2}")
}
^F3:: {
    Send("^s")
    Sleep 10
    Send("^{F3}")
}
^F4:: {
    Send("^s")
    Sleep 10
    Send("^{F4}")
}
^F5:: {
    Send("^s")
    Sleep 10
    Send("^{F5}")
}
#HotIf
#HotIf !TitleMatch(UnityMainWindow) and WinActive("Scene")
^+1:: WinClose()
#HotIf
#HotIf !TitleMatch(UnityMainWindow) and WinActive("Game")
^+2:: WinClose()
#HotIf
#HotIf !TitleMatch(UnityMainWindow) and WinActive("Simulator")
^+3:: WinClose()
#HotIf

; Open Rider
#HotIf WinActive(appUnity)
!#c:: Send("^!+o")
#HotIf

; 2D Navigation
#HotIf WinActive(appUnity) and GetFocusedText("UnityEditor.Graphs.AnimatorControllerTool") or WinActive(appUnity) and
GetFocusedText("UnityEditor.Tilemaps.GridPaintPaletteWindow") or WinActive(appUnity) and GetFocusedText(
    "AmplifyShaderEditor.AmplifyShaderEditorWindow")
*Space:: Send("{Alt Down}")
*Space Up:: Send("{Alt Up}")
#HotIf
#HotIf WinActive(appUnity) and GetFocusedTextOnClick("UnityEditor.Searcher.SearcherWindow") or WinActive(appUnity) and
GetFocusedTextOnClick("UnityEditor.VFX.UI.VFXFilterWindow")
Space:: Send("{Space}")
Tab:: Send("{Escape}")
#HotIf

; 3D Navigation
; #HotIf WinActive(appUnity)
; *Space:: {
;     isSpaceDown := false
;     if (GetFocusedText("UnityEditor.SceneView")) {
;         isSpaceDown := true
;         Send("{Alt Down}")
;         return
;     }
;     else {
;         if (isSpaceDown == true) {
;             Send("{Alt Down}")
;             return
;         }
;         else {
;             Send("{Alt Up}{Space Down}")
;             return
;         }
;     }
; }
; *Space Up:: {
;     ; Send("{Alt Up}{Space Up}")
;     Send("{Space Up}")
;     Send("{Alt Up}")
;     return
; }
; #HotIf
#HotIf WinActive(appUnity)
*Space::
{
    if GetFocusedText("UnityEditor.SceneView") {
        SendInput "{Alt down}"
        KeyWait "Space"
        SendInput "{Alt up}"
    } else {
        SendEvent "{Space down}"
        KeyWait "Space"
        SendEvent "{Space up}"
    }
}
#HotIf

OnExit AltReleaseOnExit
AltReleaseOnExit(*) {
    SendInput "{Alt up}"
}

; SceneView
#HotIf WinActive(appUnity) and GetFocusedText("UnityEditor.SceneView")
!sc056:: Send("+{sc056}")
#HotIf
#HotIf !GetKeyState("RButton", "P") and WinActive(appUnity) and GetFocusedText("UnityEditor.SceneView")
q:: Toggle("^!+1", "^!+4", 1)
+q:: Toggle("^!+2", "^!+4", 1)
#HotIf
#HotIf !GetKeyState("RButton", "P") and WinActive(appUnity) and GetFocusedTextOnClick("UnityEditor.SceneView")
a:: Send("!+a")
#HotIf

; UI Builder
#HotIf WinActive(appUnity) and GetFocusedText("Unity.UI.Builder.Builder")
F11:: Send("^b")
#HotIf

; Simulator
#HotIf WinActive(appUnity) and GetFocusedText("UnityEditor.DeviceSimulation.SimulatorWindow")
F11:: Send("^b")
#HotIf

; Search
#HotIf WinActive(appUnity) and WinExist("Search")
Escape:: WinActivateAndClose (["Search"])
#HotIf
#HotIf WinActive(appUnity) and !WinActive("Search")
!Space Up:: Send("^k")
#HotIf
#HotIf WinActive(appUnity) and WinActive("Search")
Escape:: WinClose()
!Space Up:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and GetFocusedTextOnClick("UnityEditor.ShaderGraph.Drawing.MaterialGraphEditWindow") or
WinActive(appUnity) and GetFocusedTextOnClick("UnityEditor.VFX.UI.VFXViewWindow")
!Space:: return
#HotIf

; Debugger
#HotIf WinActive(appUnity) and WinActive("Debugger") and !TitleMatch(UnityMainWindow)
d:: {
    MouseGetPos &xpos, &ypos
    Click "230 30"
    MouseMove xpos, ypos
}
#HotIf

; Create Camera
#HotIf WinActive(appUnity)
^+!c:: {
    Send("^+!c")
    Send("+!c")
}
#HotIf

; Close Modals
#HotIf WinActive(appUnity) and !TitleMatch(UnityMainWindow)
#Escape:: WinClose()
#HotIf

; Close by Escape
#HotIf WinActive(appUnity) and WinExist("Console")
Escape:: WinActivateAndClose (["Console"])
#HotIf
#HotIf WinActive(appUnity) and WinExist("Tile Palette")
Escape:: WinActivateAndClose (["Tile Palette"])
#HotIf

; Toggle Windows
#HotIf WinActive(appUnity) and WinActive("Project")
^+q:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinActive("Hierarchy")
^+w:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinActive("Inspector")
^+e:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinActive("Console")
^+c:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinActive("Project Settings")
^+p:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinActive("Package Manager")
^+x:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinActive("Build Profiles") or WinActive(appUnity) and WinActive("Build Settings")
^+b:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinActive("Lighting")
^+l:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinActivePartialMatch("Hot Reload")
^+h:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinActive("Preferences")
^,:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinActive("Shortcuts")
^.:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinActive("NuGet For Unity")
^+n:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinActive("Test Runner")
^+u:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinActive("UI Builder")
^+t:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinExist("UI Builder")
^+t:: WinActivate()
#HotIf
#HotIf WinActive(appUnity) and WinActive("UI Toolkit Debugger")
^+d:: WinClose()
#HotIf
#HotIf WinActive(appUnity) and WinExist("UI Toolkit Debugger")
^+d:: WinActivate()
#HotIf

; vPlugin
#HotIf WinActive(appUnity) and GetFocusedText("UnityEditor.InspectorWindow") or WinActive(appUnity) and GetFocusedText(
    "UnityEditor.SceneHierarchyWindow") or WinActive(appUnity) and GetFocusedText("UnityEditor.ProjectBrowser")
sc056:: Send("e")
!sc056:: Send("^+e")
#HotIf

; Timeflow
#HotIf WinActive(appUnity) and GetFocusedText("AxonGenesis.TimeflowWindow")
1:: {
    Send("^+1")
    Send("1")
}
2:: {
    Send("^+1")
    Send("2")
}
+z:: Send("!0")
!0:: return
+a:: Send("0")
f:: Send("+f")
+f:: Send("f")
,:: Send("+{PgUp}")
.:: Send("+{PgDn}")
!Left:: Send("+{PgUp}")
!Right:: Send("+{PgDn}")
PgUp:: Send("!{Left}")
PgDn:: Send("!{Right}")
Space Up:: Send("{Space Down}")
+Space Up:: Send("+{Space Down}")
^Space:: return
z:: Send(";")           ; zoom in/out
sc027:: return          ; remove original for zoom in/out
+l:: Send("^l")         ; work area & loop
^l:: return             ; remove original for work area & loop
+sc00c:: Send("1")
+sc00d:: Send("2")
Left:: Send("{PgUp}")
Right:: Send("{PgDn}")
[:: Send("!{PgUp}")
!PgUp:: return
]:: Send("!{PgDn}")
!PgDn:: return
+Left:: Send("{Home}")
+Right:: Send("{End}")
+Down:: Send("^{PgUp}")
+Up:: Send("^{PgDn}")
#HotIf