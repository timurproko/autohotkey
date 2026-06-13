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

; Terminal
#HotIf !WinExist(windowsTerminal)
#sc029:: ControlApp("launch", "C:\Users\" . A_UserName . "\AppData\Local\Microsoft\WindowsApps\wt.exe")
#HotIf
#HotIf WinActive(windowsTerminal)
#sc029:: ControlApp("minimize", windowsTerminal)
#Escape:: ControlApp("close", windowsTerminal)
#HotIf
#HotIf !WinActive(windowsTerminal)
#sc029:: ControlApp("activate", windowsTerminal)
#HotIf

; Win + Backspace : Recycle Bin
#BackSpace:: Run(A_ComSpec " /c `"echo Y|PowerShell -NoProfile -Command Clear-RecycleBin`"", , "Hide")

; Windows Terminal General
global toggleMode := 0
global lastKey := ""

#HotIf WinActive(windowsTerminal)
!Space:: Send("^+p")
^c:: Send("^+c")
^v:: Send("{RButton}")
^+q:: Send("+{Tab}")
#HotIf

#HotIf WinActive(weztermTerminal)
#Escape:: WinClose
!Space:: Send("^+p")
^+q:: Send("+{Tab}")
#HotIf

; Git Bash
#HotIf WinActive(windowsTerminal) and WinActive("Git Bash") or WinActive(weztermTerminal) and WinActive("bash.exe")
^g:: {
    Send("^u")
    return
}

#HotIf A_PriorHotkey = "^g"
*a:: RunTerminalCommand('a', 'git add ')
*b:: RunTerminalCommand('b', 'git branch ')
*c:: RunTerminalCommand('c', 'git clean -fd')
*d:: RunTerminalCommand('d', 'git diff ')
*e:: RunTerminalCommand('e', 'open .')
*f:: RunTerminalCommand('f', 'git fetch origin')
*g:: RunTerminalCommand('g', 'lazygit', , true)
*h:: RunTerminalCommand('h', 'git switch ')
*k:: RunTerminalCommand('k', 'rm -f .git/index.lock')
*l:: RunTerminalCommand('l', 'git log', 'git log --oneline')
*m:: RunTerminalCommand('m', 'git merge ')
*n:: RunTerminalCommand('n', 'git clone ')
*o:: RunTerminalCommand('o', 'git checkout ')
*p:: RunTerminalCommand('p', 'git push origin HEAD')
*q:: RunTerminalCommand('q', 'git commit -m "', 'git commit --amend -m "')
*r:: RunTerminalCommand('r', 'git restore ', 'git restore --staged ')
*s:: RunTerminalCommand('s', 'git status')
*u:: RunTerminalCommand('u', 'git pull')
*x:: RunTerminalCommand('x', 'git reset --hard HEAD')
*w:: RunTerminalCommand('w', 'git show --name-only ')
#HotIf
#HotIf