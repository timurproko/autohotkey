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

; Browsers
#HotIf WinActive(browserChrome) or WinActive(browserEdge) or WinActive(browserFirefox)
#Escape:: WinClose
#HotIf

; Opera Browser
#HotIf WinActive(browserOpera)
!Space:: Send("^{Space}")
^Space:: return
#HotIf

; Arc Browser
; Settings
#HotIf A_PriorHotkey = "!Space"
^+,:: SendText("arc://settings/")
^+a:: SendText("arc://accessibility/")
^+x:: SendText("arc://extensions/")
#HotIf
; General
#HotIf WinActive(browserArc)
^Escape:: Send("{f11}")
!Space:: Send("^{sc014}")
^w:: {
    if (GetUrlRaw()) {
        Send("^{sc011}")
    }
    else {
        return
    }
}
^+BackSpace:: Send("^+{sc025}")

; Sites
;== (Space) ==
^+Space:: {
    if (GetUrlValue("https://chatgpt.com/")) {
        Send("^{sc025}")
    }
    else if (GetUrlValue("https://music.youtube.com/")) {
        Send("/")
        Send("{Backspace}")
    }
    else if (GetUrlValue("https://www.youtube.com/")) {
        Send("/")
        Send("{Backspace}")
    }
    else if (GetUrlValue("https://trello.com/")) {
        Toggle("/", "{Escape}")
    }
    else {
        Send("^+{Space}")
    }
}

;== (Escape) ==
Escape:: {
    if (GetUrlValue("https://chatgpt.com/")) {
        Send("+{Escape}")
    }
    else if (GetUrlValue("https://www.google.com/search")) {
        Send("/")
        Send("{Backspace}")
    }
    else {
        Send("{Escape}")
    }
}

;== (Enter) ==
Enter:: {
    if (GetUrlValue("https://chatgpt.com/") or GetUrlValue("https://chat.deepseek.com/") or GetUrlValue(
        "https://copilot.microsoft.com/") or GetUrlValue("https://gemini.google.com/") or GetUrlValue(
            "https://teams.microsoft.com/") or GetUrlValue("https://discord.com/channels/") or GetUrlValue(
                "https://www.linkedin.com/messaging/") or GetUrlValue("https://web.telegram.org/")
            or GetUrlValue("https://app.slack.com/")) {
        Send("+{sc01c}")
    }
    else {
        Send("{sc01c}")
    }
}
^Enter:: {
    if (GetUrlValue("https://discord.com/channels/") or GetUrlValue("https://chat.deepseek.com/") or GetUrlValue(
        "https://www.linkedin.com/messaging/") or GetUrlValue("https://web.telegram.org/") or GetUrlValue("https://app.slack.com/")) {
        Send("{sc01c}")
    }
    else if (GetUrlValue("https://chatgpt.com/")) {
        Send("#!{sc01c}")
    }
    else {
        Send("^{sc01c}")
    }
}

;== (-) ==
sc00c:: {
    if (GetUrlValue("https://www.youtube.com/watch")) {
        Send("+{sc033}")
    }
    else if (GetUrlValue("https://www.udemy.com/")) {
        Send("+{Left}")
    }
    else {
        Send("{sc00c}")
    }
}

;== (+) ==
sc00d:: {
    if (GetUrlValue("https://www.youtube.com/watch")) {
        Send("+{sc034}")
    }
    else if (GetUrlValue("https://www.udemy.com/")) {
        Send("+{Right}")
    }
    else {
        Send("{sc00d}")
    }
}

;== (Arrows) ==
+Left:: {
    if (GetUrlValue("https://www.udemy.com/")) {
        return
    }
    else if (GetUrlValue("https://www.youtube.com/watch")) {
        Send("{sc024}")
    }
    else {
        Send("+{Left}")
    }
}

+Right:: {
    if (GetUrlValue("https://www.udemy.com/")) {
        return
    }
    else if (GetUrlValue("https://www.youtube.com/watch")) {
        Send("{sc026}")
    }
    else {
        Send("+{Right}")
    }
}

;== (.) ==
^+.:: {
    if (GetUrlValue("https://chatgpt.com/")) {
        Send("^{sc035}")
    }
    else if (GetUrlValue("https://music.youtube.com/")) {
        Send("+/")
    }
    else {
        Send("^+{sc034}")
    }
}

;== (1) ==
;== (2) ==
;== (3) ==
;== (4) ==
;== (5) ==
;== (6) ==
;== (7) ==
;== (8) ==
;== (9) ==
;== (0) ==
;== (A) ==

;== (B) ==
^+b:: {
    if (GetUrlValue("https://chatgpt.com/")) {
        Send("^+{sc01f}")
    }
    else if (GetUrlValue("https://www.notion.so/")) {
        Send("^{sc02b}")
    }
    else if (GetUrlValue("https://www.figma.com/")) {
        Send("^+{sc02b}")
    }
    else if (GetUrlValue("atlassian.net/jira/")) {
        Send("[")
    }
    else {
        Send("^+{sc030}")
    }
}

;== (C) ==
;== (D) ==
;== (E) ==
;== (F) ==
;== (J) ==
;== (H) ==
;== (I) ==
;== (J) ==
;== (K) ==
;== (L) ==
;== (M) ==
;== (N) ==
;== (O) ==

;== (P) ==
^+p:: {
    if (GetUrlValue("https://chatgpt.com/")) {
        Send("^{sc025}")
    }
    else {
        Send("^+{sc019}")
    }
}

;== (Q) ==
;== (R) ==
;== (S) ==
;== (T) ==
;== (U) ==
;== (V) ==
;== (W) ==
;== (X) ==
;== (Y) ==
;== (Z) ==
;== (F1) ==
;== (F2) ==
F2:: {
    if (GetUrlValue("https://www.figma.com/")) {
        Send("^r")
    }
    else {
        Send("{F2}")
    }
}
;== (F3) ==
;== (F4) ==
;== (F5) ==
;== (F6) ==

;== (F7) ==
F7:: {
    if (GetUrlValue("https://www.youtube.com/watch")) {
        Send("+{sc019}")
    }
    else if (GetUrlValue("https://www.udemy.com/")) {
        Send("{sc04b}")
    }
    else if (GetUrlValue("https://music.youtube.com/")) {
        Send("{sc025}")
    }
    else {
        Send("{sc041}")
    }
}

;== (F8) ==
F8:: {
    if (GetUrlValue("https://www.youtube.com/watch") or GetUrlValue("https://www.udemy.com/")) {
        Send("{sc039}")
    }
    else if (GetUrlValue("https://music.youtube.com/")) {
        Send("{Space}")
    }
    else {
        Send("{sc042}")
    }
}

;== (F9) ==
F9:: {
    if (GetUrlValue("https://www.youtube.com/watch")) {
        Send("+{sc031}")
    }
    else if (GetUrlValue("https://www.udemy.com/")) {
        Send("{sc04d}")
    }
    else if (GetUrlValue("https://music.youtube.com/")) {
        Send("{sc024}")
    }
    else {
        Send("{sc043}")
    }
}

;== (F10) ==
F10:: {
    if (GetUrlValue("https://www.youtube.com/watch") or GetUrlValue("https://www.udemy.com/")) {
        Send("{sc032}")
    }
    else if (GetUrlValue("https://music.youtube.com/")) {
        Send("{sc032}")
    }
    else {
        Send("{sc044}")
    }
}

;== (F11) ==
F11:: {
    if (GetUrlValue("https://www.youtube.com/watch") or GetUrlValue("https://www.udemy.com/")) {
        Send("{sc050}")
    }
    else if (GetUrlValue("https://music.youtube.com/")) {
        Send("{sc00c}")
    }
    else {
        Send("{sc057}")
    }
}

;== (F12) ==
F12:: {
    if (GetUrlValue("https://www.youtube.com/watch") or GetUrlValue("https://www.udemy.com/")) {
        Send("{sc048}")
    }
    else if (GetUrlValue("https://music.youtube.com/")) {
        Send("{sc00d}")
    }
    else {
        Send("{sc058}")
    }
}

;== (Other) ==
^.:: {
    if (GetUrlValue("https://editor.rive.app/")) {
        Send("+{/}")
    }
    else {
        Send("^{,}")
    }
}
#HotIf