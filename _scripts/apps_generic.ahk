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

; Hide
#HotIf  WinActive(windowsTeams)
Escape:: WinClose
#HotIf

; Close
#HotIf WinActive(app7zip) or WinActive(appOutlook)
#Escape:: WinClose
#HotIf
#HotIf WinActive(windowsTeams)
#Escape:: ProcessClose ("ms-teams.exe")
#HotIf
#HotIf WinActive(windowsOneDrive)
#Escape:: ProcessClose ("OneDrive.exe")
#HotIf

; Enter
#HotIf WinActive(windowsCopilot)
sc01c:: Send("+{sc01c}")
#HotIf
#HotIf WinActive(windowsCopilot)
^sc01c:: Send("{sc01c}")
#HotIf

; Windows Terminal
global toggleMode := 0
global lastGitKey := ""

#HotIf WinActive(windowsTerminal)
!Space:: Send("^+p")
^Backspace:: {
    Send("clear")
    Send("{Enter}")
}
Escape:: Send("^c")
^c:: Send("^+c")
^v:: {
    ClipWait
    A_Clipboard := A_Clipboard
    Sleep 10
    Send(Trim(A_Clipboard, " "))
}
^g:: {
    Send("^u")
    return
}
#HotIf
#HotIf A_PriorHotkey = "^g"
*a:: RunGitCommand('a', 'git add .')
*b:: RunGitCommand('b', 'git branch')
*c:: RunGitCommand('c', 'git clean -fd')
*d:: RunGitCommand('d', 'git diff')
*e:: RunGitCommand('e', 'open .')
*i:: RunGitCommand('i', 'git switch ')
*k:: RunGitCommand('k', 'rm -f .git/index.lock')
*l:: RunGitCommand('l', 'git log', 'git log --oneline')
*m:: RunGitCommand('m', 'git merge')
*n:: RunGitCommand('n', 'git clone ')
*o:: RunGitCommand('o', 'git checkout ')
*p:: RunGitCommand('p', 'git push origin HEAD')
*q:: RunGitCommand('q', 'git commit -m "', 'git commit --amend -m "')
*r:: RunGitCommand('r', 'git restore ', 'git restore --staged ')
*s:: RunGitCommand('s', 'git status')
*u:: RunGitCommand('u', 'git pull')
*x:: RunGitCommand('x', 'git reset --hard HEAD')
*w:: RunGitCommand('w', 'git show --name-only')
; *r:: RunGitCommand('r', 'git remote set-url origin ')
#HotIf

; Elgato
#HotIf WinActive(appElgatoCameraHub)
Escape:: WinClose
#Escape:: ProcessClose "Camera Hub.exe"
#HotIf

; JetBrains
#HotIf WinActive(appJBRider)
!Space:: Send("^+p")
#HotIf
#HotIf WinActive(appJBToolbox)
#Escape:: Send("^q")
#HotIf

; VSCode
#HotIf WinActive(appVSCode) or WinActive(appCursor)
!Space:: Send("^+p")
#HotIf
#HotIf WinActive(appVSCode)
^+e:: Toggle("^+e", "^b", 1)
^+x:: Toggle("^+x", "^b", 1)
^+f:: Toggle("^+f", "^b", 1)
#HotIf
#HotIf WinActive(appVSCode) and WinExist(appHindie)
Escape:: WinActivate(appHindie)
#HotIf
; #HotIf WinActive(appVSCode) and WinExist(appHoudini)
; Escape:: WinActivate(appHoudini)
; #HotIf

; Spotify
#HotIf WinActive(appSpotify) and A_PriorHotkey = "!Space"
Escape:: Send("{Escape}")
#HotIf
#HotIf WinActive(appSpotify) and A_PriorHotkey != "!Space"
Escape:: ControlApp("close", appSpotify)
#HotIf
#HotIf WinActive(appSpotify)
^Escape:: Send("{Escape}")
!Space:: Send("^k")
^,:: Toggle("^p", "!{Left}", 1)
f8:: Send("{Space}")
f7:: Send("^{Left}")
f9:: Send("^{Right}")
f11:: Send("^{Down}")
f12:: Send("^{Up}")
!0:: Send("!+0")
!1:: Send("!+1")
!2:: Send("!+2")
!3:: Send("!+3")
!4:: Send("!+4")
!5:: Send("!+5")
^+n:: return
^+b:: Send("!+l")
^+f8:: Send("!+j")
#HotIf

; Notion
#HotIf WinActive(appNotion) and A_PriorHotkey = "!Space"
Escape:: Send("{Escape}")
#HotIf
#HotIf WinActive(appNotion) and A_PriorHotkey != "!Space"
Escape:: ControlApp("close", appNotion)
#HotIf
#HotIf WinActive(appNotion)
^Escape:: Send("{Escape}")
!Space:: Send("^p")
^+b:: Send("^\")
!Left:: Send("^[")
!Right:: Send("^]")
#HotIf

; Eagle
#HotIf WinActive(appEagle)
^b:: Send("{f5}")
^e:: Send("^{Enter}")
+Enter:: {
    Send("+{Enter}")
    Sleep 500
    WinClose
}
!Space:: Send("^f")
#HotIf

; 1Password
#HotIf WinActive(app1Password)
^+b:: Send("^+d")
^+d:: return
!Space:: Send("^f")
^LButton:: {
    Send("{LButton}")
    WinClose
}
#HotIf

; MagicPods
#HotIf WinActive(appMagicPods)
Tab:: ClickAtPosition("100%-180px", "160px")
#HotIf

; JBL Quantum App
#HotIf WinActive("ahk_exe QuantumApp.exe")
#Escape:: ProcessClose "QuantumApp.exe"
Escape:: WinClose
#HotIf

; Meta
#HotIf WinActive("ahk_exe Meta Quest Developer Hub.exe")
#Escape:: WinClose
Escape:: WinMinimize
#HotIf

; OBS
#HotIf WinActive(appOBS)
f8:: {
    Send("{f8}")
    WinHide
}
#HotIf

; VLC
#HotIf WinActive(appVLC)
#Escape:: ProcessClose "VLC.exe"
^,:: Send("^p")
=:: Send("]")
-:: Send("[")
0:: Send("=")
[:: return
]:: return
#HotIf

; TunnelBear
#HotIf WinActive(appTunnelBear)
Tab:: ClickAtPosition(130, 50)
#HotIf

; Telegram
#HotIf WinActive(appTelegram) and WinActive("Media viewer")
Left:: return
Right:: return
#HotIf

; Messanger Apps
#HotIf WinActive(appTelegram) or WinActive(appViber) or WinActive(appDiscord)
sc01c:: Send("+{sc01c}")
^sc01c:: Send("{sc01c}")
#HotIf

; Zppm
#HotIf WinActive("Zoom Meeting")
sc01c:: Send("+{sc01c}")
^sc01c:: Send("{sc01c}")
#HotIf
#HotIf WinActive("Zoom Workplace")
Esc:: WinHide
#HotIf

; Media Player
#HotIf WinActive(windowsMediaPlayer)
Tab:: Send("{f11}")
Right:: Send("^{Right}")
Left:: Send("^{Left}")
#HotIf

; DaVinci Resolve
#HotIf WinActive(appResolve)
F11:: Send("^f")
#HotIf

; Figma
#HotIf WinActive(appFigma)
F2:: Click 2
#HotIf

; FMOD
#HotIf WinActive(appFMOD) and WinGetList(appFMOD).Length > 1
Escape:: WinClose
#HotIf