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

; Win+A : Allway On Top
#a:: SetAllwayOnTop

; Win+B : System Tray Overflow Window
#b:: ShowTaskbarHiddenIcons

; Win+E : Empty
#e:: return

; Win+F : Maximize
#HotIf !WinActive(windowsTaskbarPopups) and !WinActive(windowsTaskbarTray)
#f:: MyWinMaximize
#HotIf

; Win+I : Empty
#i:: return

; Win+J : Emoji
#j:: Send("#{sc034}")

; Win+M : Notification Popup
#m:: Send("#n")

; Win+M : WiFi Popup
#n:: Send("#a")

; Win+O : Empty
#o:: return

; Win+Q : Empty
#q:: return

; Win+S : Screen Capture
#s:: Send("+#s")
#+s:: Send("+#r")

; Win+U : Empty
#u:: return

; Alt+V : Paste Without Formatting
!v:: {
    if (WinActive(browserArc) and GetUrlValue("https://app.slack.com/") or WinActive(appCursor) or WinActive(appVSCode) or
    WinActive(appJBRider)) {
        Send("!{v}")
    }
    else {
        PasteWithoutFormatting
    }
}

; Win+W : Empty
#w:: ControlApp("launch", "explorer.exe")

; Change Language
#f1:: SetLanguage("en")
#f2:: SetLanguage("ru")
#f3:: SetLanguage("ua")

; F1 : Help;
F1::
{
    if WinActive("ahk_exe explorer.exe")
        return

    if WinActive(browserChrome) || WinActive(browserArc) {
        Run 'chrome.exe "' windowsHelp '"'
        return
    }

    if WinActive(browserEdge) {
        Run 'msedge.exe "' windowsHelp '"'
        return
    }

    if (WinActive(browserArc)) {
        arcPath := EnvGet("LOCALAPPDATA") "\Microsoft\WindowsApps\arc.exe"
        Run('"' arcPath '" "' windowsHelp '"')
        return
    }

    Run(windowsHelp)
}

; Refresh Process
+#r:: RefreshWindowsExplorer
+#u:: ProcessClose "unity.exe"
+#a:: ProcessClose "arc.exe"

; Window Management
^LWin Up:: {
    Send("{LWin up}")
    return
}
^#Right:: {
    Send("{LWin down}{Right}")
    return
}
^#Left:: {
    Send("{LWin down}{Left}")
    return
}
^#Up:: {
    Send("{LWin down}{Up}")
    return
}
^#Down:: {

    Send("{LWin down}{Down}")
    return
}

; Task Manager
#Delete:: Send("^+{Escape}")
if (ProcessExist(windowsTaskmgr)) {
    #Escape:: ProcessClose "Taskmgr.exe"
}

; Virtual Desktops
#Right::
{
    SendEvent("{LWin down}{LCtrl down}{Right down}")
    Sleep TIMEOUT
    SendEvent("{Right up}{LWin up}{LCtrl up}")
    return
}
#Left::
{
    SendEvent("{LWin down}{LCtrl down}{Left down}")
    Sleep TIMEOUT
    SendEvent("{Left up}{LWin up}{LCtrl up}")
    return
}
#-:: Send("#^{f4}")
#=:: Send("#^d")

; Passthrough Symbols
#;:: Send(";")  ; Emoji
#.:: Send(".")  ; Emoji
#\:: Send("\")  ; \
#/:: Send("/")  ; /

; Win+\ : Minimize/Activate
#sc056:: {
    if (WinGetStateUnderCursor()) {
        MyWinMinimize
        WinActivateUnderCursor
    } else {
        DeactivateAll
        WinActivateUnderCursor
    }
}

; Win+Space : Search
#HotIf !WinActive(windowsSearch)
#Space:: Send("#s")
#HotIf
#HotIf WinActive(windowsSearch)
#Space:: Send("{Escape}")
#HotIf

; Windows Calculator
#HotIf WinActive(windowsCalculator)
sc059:: Send("{Enter}")
sc067:: Send("%")
sc068:: Send("{Delete}")
sc069:: Send("{Escape}")
sc06A:: Send("{Backspace}")
#HotIf

; Windows Explorer
; Show/Hide Hidden Files
#HotIf (WinActive(windowsExplorer) and WinActive(windowsExplorerClass)) or WinActive("ahk_class #32770")
value2 := RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\", "Hidden", 2)
^+h::
{
    global
    if (value2 = 1)
        value2 := "2"
    else
        value2 := "1"
    RegWrite(value2, "REG_DWORD", "HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced\",
        "Hidden")
    Send("{f5}")
}

; Navigate to Down
!Down:: Send("{Enter}")
#HotIf

; Close
#HotIf WinActive("ahk_exe SnippingTool.exe") or WinActive("ahk_exe mspaint.exe")
#Escape:: WinClose
#HotIf

; Win + Backspace : Recycle Bin
#BackSpace:: Run(A_ComSpec " /c `"echo Y|PowerShell -NoProfile -Command Clear-RecycleBin`"", , "Hide")

; Ctrl+Alt+Shift + D : Toggle Monitor Resolution
^+!d:: Run('"' A_AhkPath '" "' A_ScriptDir '\_mytools\mytools_toggleResolution.ahk"')