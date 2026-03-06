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

; Windows Apps
; Terminal
#HotIf !WinExist(windowsTerminal)
#sc029:: ControlApp("launch", "C:\Users\" . A_UserName . "\AppData\Local\Microsoft\WindowsApps\wt.exe", "maximized")
#HotIf
#HotIf WinActive(windowsTerminal)
#sc029:: ControlApp("minimize", windowsTerminal)
#Escape:: ControlApp("close", windowsTerminal)
#HotIf
#HotIf !WinActive(windowsTerminal)
#sc029:: ControlApp("activate", windowsTerminal)
#HotIf

; Settings
#HotIf !WinExist(windowsSettings)
#,:: ControlApp("launch", "ms-settings:", "maximized")
#HotIf
#HotIf WinActive(windowsSettings)
#,:: ControlApp("minimize", windowsSettings)
#Escape:: ControlApp("close", windowsSettings)
#HotIf
#HotIf !WinActive(windowsSettings)
#,:: ControlApp("activate", windowsSettings)
#HotIf

; Notepad
#HotIf WinActive(windowsNotepad)
#Escape:: ControlApp("close", windowsNotepad)
#HotIf

; Explorer
#HotIf WinActive(windowsExplorer) and WinActive(windowsExplorerClass)
#Escape:: ControlApp("close", windowsExplorer)
#HotIf

; Windows Folders
windowsFolder1 := "This PC - File Explorer"
windowsFolder2 := A_UserName
windowsFolder3 := "Downloads - File Explorer"
windowsFolder4 := "_scripts - File Explorer"

#HotIf !WinExist(windowsFolder1) and !WinActive(windowsCalculator)
sc067:: ControlApp("launch", "C:\Windows\explorer.exe /e,::{20D04FE0-3AEA-1069-A2D8-08002B30309D}")
#HotIf
#HotIf WinActive(windowsFolder1) and !WinActive(windowsCalculator)
sc067:: ControlApp("close", windowsFolder1)
#HotIf
#HotIf !WinActive(windowsFolder1) and !WinActive(windowsCalculator)
sc067:: ControlApp("activate", windowsFolder1)
#HotIf

#HotIf !WinExist(windowsFolder2) and !WinActive(windowsCalculator)
; sc069:: ControlApp("launch", A_MyDocuments)
sc068:: ControlApp("launch", "C:\Users\" . A_UserName . "\")
#HotIf
#HotIf WinActive(windowsFolder2) and !WinActive(windowsCalculator)
sc068:: ControlApp("close", windowsFolder2)
#HotIf
#HotIf !WinActive(windowsFolder2) and !WinActive(windowsCalculator)
sc068:: ControlApp("activate", windowsFolder2)
#HotIf

#HotIf !WinExist(windowsFolder3) and !WinActive(windowsCalculator)
sc069:: ControlApp("launch", "C:\Users\" . A_UserName . "\Downloads")
#HotIf
#HotIf WinActive(windowsFolder3) and !WinActive(windowsCalculator)
sc069:: ControlApp("close", windowsFolder3)
#HotIf
#HotIf !WinActive(windowsFolder3) and !WinActive(windowsCalculator)
sc069:: ControlApp("activate", windowsFolder3)
#HotIf

#HotIf !WinExist(windowsFolder4) and !WinActive(windowsCalculator)
sc06A:: ControlApp("launch", A_ScriptDir)
#HotIf
#HotIf WinActive(windowsFolder4) and !WinActive(windowsCalculator)
sc06A:: ControlApp("close", windowsFolder4)
#HotIf
#HotIf !WinActive(windowsFolder4) and !WinActive(windowsCalculator)
sc06A:: ControlApp("activate", windowsFolder4)
#HotIf

; MagicPods
#HotIf !WinExist(appMagicPods)
!#f12:: ControlApp("launch", "explorer.exe shell:AppsFolder\715AleksandrMaslov.MagicPods_vk1h99z2mpttm!App")
#HotIf
#HotIf WinActive(appMagicPods)
!#f12:: ControlApp("close", appMagicPods)
Escape:: ControlApp("close", appMagicPods)
#HotIf
#HotIf !WinActive(appMagicPods)
!#f12:: ControlApp("activate", appMagicPods)
#HotIf

; Calculator
#HotIf !WinExist(windowsCalculator)
#sc052:: ControlApp("launch", "calc.exe")
#HotIf
#HotIf WinActive(windowsCalculator)
#sc052:: ControlApp("close", windowsCalculator)
#Escape:: ControlApp("close", windowsCalculator)
#HotIf
#HotIf !WinActive(windowsCalculator)
#sc052:: ControlApp("activate", windowsCalculator)
#HotIf

; Arc Browser
#HotIf !WinExist(browserArc)
!#a:: ControlApp("launch", A_Programs . "/Arc", "maximized")
#HotIf
#HotIf WinActive(browserArc)
!#a:: ControlApp("minimize", browserArc)
; #Escape:: ControlApp("close", browserArc)
#HotIf
#HotIf !WinActive(browserArc)
!#a:: ControlApp("activate", browserArc)
#HotIf

; Copilot
; #HotIf !WinExist(windowsCopilot)
; !#a:: ControlApp("launch", "explorer.exe shell:AppsFolder\Microsoft.MicrosoftOfficeHub_8wekyb3d8bbwe!Microsoft.MicrosoftOfficeHub")
; #HotIf
; #HotIf WinActive(windowsCopilot)
; !#a:: ControlApp("minimize", windowsCopilot)
; Escape:: ControlApp("close", windowsCopilot)
; #Escape:: ProcessClose("M365Copilot.exe")
; #HotIf
; #HotIf !WinActive(windowsCopilot)
; !#a:: ControlApp("activate", windowsCopilot)
; #HotIf

; Tray Apps
; Spotify
#HotIf !WinExist(appSpotify)
!#m:: ControlApp("launch", A_Programs . "/Spotify", "maximized")
#HotIf
#HotIf WinActive(appSpotify)
!#m:: ControlApp("close", appSpotify)
#Escape:: ProcessClose "spotify.exe"
#HotIf
#HotIf !WinActive(appSpotify)
!#m:: ControlApp("activate", appSpotify)
#HotIf

; Notion
#HotIf !WinExist(appNotion)
!#n:: ControlApp("launch", A_Programs . "/Notion", "maximized")
#HotIf
#HotIf WinActive(appNotion)
!#n:: ControlApp("close", appNotion)
#Escape:: ProcessClose "notion.exe"
#HotIf
#HotIf !WinActive(appNotion)
!#n:: ControlApp("activate", appNotion)
#HotIf

; Eagle
#HotIf !WinExist(appEagle)
!#e:: ControlApp("launch", A_Programs . "/Eagle")
#HotIf
#HotIf WinActive(appEagle)
!#e:: ControlApp("close", appEagle)
Escape:: ControlApp("close", appEagle)
#Escape:: ProcessClose "eagle.exe"
#HotIf
#HotIf !WinActive(appEagle)
!#e:: ControlApp("activate", appEagle)
#HotIf

; Oculus
#HotIf !WinExist(appOculus)
!#q:: ControlApp("launch", A_StartMenuCommon . "/Meta Horizon Link/Meta Horizon Link")
#HotIf
#HotIf WinActive(appOculus)
!#q:: ControlApp("close", appOculus)
Escape:: ControlApp("close", appOculus)
#Escape:: ProcessClose "Client.exe"
#HotIf
#HotIf !WinActive(appOculus)
!#q:: ControlApp("activate", appOculus)
#HotIf

; 1Password
#HotIf !WinExist(app1Password)
!#p:: RunStoreApp("1Password")
#HotIf
#HotIf WinActive(app1Password)
!#p:: ControlApp("close", app1Password)
Escape:: ControlApp("close", app1Password)
#Escape:: ProcessClose "1Password.exe"
#HotIf
#HotIf !WinActive(app1Password)
!#p:: ControlApp("activate", app1Password)
#HotIf

; Unity Hub
#HotIf !WinExist(appUnityHub)
!#u:: ControlApp("launch", A_StartMenuCommon . "/Programs/Unity Hub", "maximized")
#HotIf
#HotIf WinActive(appUnityHub)
!#u:: ControlApp("close", appUnityHub)
Escape:: ControlApp("close", appUnityHub)
#Escape:: ProcessClose "Unity Hub.exe"
#HotIf
#HotIf !WinActive(appUnityHub)
!#u:: ControlApp("activate", appUnityHub)
#HotIf

; TunnelBear
#HotIf !WinExist(appTunnelBear)
!#t:: ControlApp("launch", A_StartMenuCommon . "/Programs/TunnelBear/TunnelBear")
#HotIf
#HotIf WinActive(appTunnelBear)
!#t:: ControlApp("close", appTunnelBear)
Escape:: ControlApp("close", appTunnelBear)
#Escape:: ProcessClose "TunnelBear.UI.exe"
#HotIf
#HotIf !WinActive(appTunnelBear)
!#t:: ControlApp("activate", appTunnelBear)
#HotIf

; OBS
#HotIf !ProcessExist("obs64.exe")
!#o:: ControlApp("launch", A_StartMenuCommon . "/Programs/OBS Studio")
#HotIf
#HotIf WinActive(appOBS)
!#o:: ControlApp("hide", appOBS)
Escape:: ControlApp("hide", appOBS)
#Escape:: ControlApp("close", appOBS)
#HotIf
#HotIf !WinActive(appOBS)
!#o:: {
    WinShow("OBS")
    WinActivate(appOBS)
    Sleep 100
    WinActivateUnderCursor
}
#HotIf

; Messangers Apps
; Telegram
#HotIf WinActive(appTelegram)
Escape:: ControlApp("close", appTelegram)
#Escape:: ProcessClose "Telegram.exe"
#HotIf

; Viber
#HotIf WinActive(appViber)
Escape:: ControlApp("close", appViber)
#Escape:: ProcessClose "Viber.exe"
#HotIf

; Discord
#HotIf WinActive(appDiscord)
Escape:: ControlApp("close", appDiscord)
#Escape:: ProcessClose "Discord.exe"
#HotIf

; TaskBar Apps
; Rider
#HotIf !WinExist(appJBRider) and !WinActive(appUnity)
!#c:: ControlApp("launch", A_Programs . "/JetBrains Toolbox/Rider", "maximized")
#HotIf
#HotIf WinActive(appJBRider) and !WinActive(appUnity)
!#c:: ControlApp("minimize", appJBRider)
#Escape:: ControlApp("close", appJBRider)
#HotIf
#HotIf !WinActive(appJBRider) and !WinActive(appUnity)
!#c:: ControlApp("activate", appJBRider)
#HotIf

; VSCode
#HotIf !WinExist(appVSCode)
!#v:: ControlApp("launch", A_Programs . "/Visual Studio Code/Visual Studio Code", "maximized")
#HotIf
#HotIf WinActive(appVSCode)
!#v:: ControlApp("minimize", appVSCode)
#Escape:: ControlApp("close", appVSCode)
#HotIf
#HotIf !WinActive(appVSCode)
!#v:: ControlApp("activate", appVSCode)
#HotIf

; Cursor
#HotIf WinActive(appCursor)
#Escape:: ControlApp("close", appCursor)
#HotIf
