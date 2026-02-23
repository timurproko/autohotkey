#Include "mytools_constants.ahk"
#Include "mytools_geturl.ahk"

PasteWithoutFormatting() {
    ClipWait
    A_Clipboard := A_Clipboard
    Sleep 10
    Send(Trim(A_Clipboard, "`t`r`n"))
}

RunAsAdmin() {
    if not A_IsAdmin
        Run("*RunAs `"" A_ScriptFullPath "`"")
}

RefreshWindowsExplorer() {
    RefreshStickyKeys
    ProcessClose "explorer.exe"
    Sleep TIMEOUT
    WinActivateUnderCursor
}

RefreshStickyKeys() {
    Send("{LCtrl Up}")
    Send("{LShift Up}")
    Send("{LAlt Up}")
    Send("{LWin Up}")
    Send("{RCtrl Up}")
    Send("{RShift Up}")
    Send("{RAlt Up}")
    Send("{RWin Up}")
}

WinActivePartialMatch(substrings*) {
    title := WinGetTitle("A")
    for substring in substrings {
        if !InStr(title, substring)
            return false
    }
    return true
}

RunGitCommand(key, cmd1, cmd2 := "") {
    global toggleMode, lastGitKey

    if (lastGitKey != key) {
        toggleMode := 0
        lastGitKey := key
    }

    if (cmd2 = "") {
        Send(cmd1)
    } else {
        if (toggleMode = 0) {
            Send(cmd1)
            toggleMode := 1
        } else {
            Send(cmd2)
            toggleMode := 0
        }
    }
}

ControlApp(action, app, mode := "") {
    if (action = "launch") {
        if (mode = "maximized") {
            MyRun(app, "Max")
        }
        else if (mode = "minimized") {
            MyRun(app, "Min")
        } else {
            MyRun(app)
        }
    }
    else if (action = "minimize") {
        if WinActive(app) {
            Send("!{Escape}")
            WinMinimize
        }
    }
    else if (action = "close") {
        if WinActive(app) {
            WinClose
            Sleep TIMEOUT
            if (!WinCheckClassUnderCursor("Progman") && !WinCheckClassUnderCursor("WorkerW")) {
                WinActivateUnderCursor()
            } else {
                return
            }
        }
    }
    else if (action = "activate") {
        if !WinActive(app) {
            WinActivate app
        }
    }
    else if (action = "hide") {
        if WinActive(app) {
            WinHide app
        }
    }
    else if (action = "show") {
        if WinActive(app) {
            WinShow app
        }
    }
}

RunStoreApp(query) {
    apps := ComObject("Shell.Application").NameSpace("shell:AppsFolder").Items
    for app in apps
        if (app.Name = query || app.Path = query || InStr(app.Name, query))
            return app.InvokeVerb("open")
}

MyRun(app, mode := "") {
    try
    {
        DeactivateAll
        Sleep TIMEOUT
        Run app, , mode, &pid
    }
}

DeactivateAll() {
    WinActivate(windowsDesktop)
}

GetKeyboardLanguage(current) {
    tid := 0
    gti := Buffer(72, 0)
    NumPut("UInt", 72, gti, 0)
    if DllCall("GetGUIThreadInfo", "UInt", 0, "Ptr", gti) {
        for hwnd in [NumGet(gti, 16, "Ptr"), NumGet(gti, 48, "Ptr"), NumGet(gti, 8, "Ptr")]
            if hwnd && (tid := DllCall("GetWindowThreadProcessId", "Ptr", hwnd, "Ptr", 0))
                break
    }
    if !tid
        tid := DllCall("GetWindowThreadProcessId", "Ptr", DllCall("GetForegroundWindow"), "Ptr", 0)
    l := DllCall("GetKeyboardLayout", "UInt", tid)
    return (l = current)
}

SetLanguage(lang) {
    try {
        static msg := WM_INPUTLANGCHANGEREQUEST := 0x50, langChange := INPUTLANGCHANGE_SYSCHARSET := 1
        langId := { en: 0x409, ua: 0x422, ru: 0x419 }.%lang%
        hWnd := ControlGetFocus("A") || WinExist("A")
        SendMessage(msg, langChange, langId, , hWnd)
    }
}

ToggleLanguage() {
    if (GetKeyboardLanguage(en
    )) {
        SetLanguage("ru")
    }
    else if (GetKeyboardLanguage(ru)) {
        SetLanguage("ua")
    }
    else if (GetKeyboardLanguage(ua)) {
        SetLanguage("en")
    }
}

SetAllwayOnTop() {
    winID := WinGetid("A")

    ExStyle := WinGetExStyle("ahk_id " winID)
    if (ExStyle & 0x8)  ; 0x8 is WS_EX_TOPMOST
    {
        WinSetalwaysontop(0, "ahk_id " winID)
    }
    else {
        WinSetalwaysontop(1, "ahk_id " winID)
    }
}

ShowTaskbarHiddenIcons() {
    if (WinActive(windowsTaskbarTray)) {
        Send("{Escape}")
        Send("!{Escape}")
    }
    else {
        Send("#b")
        Send("{Enter}")
    }
}

ClickAtPosition(x, y) {
    WinGetClientPos &OutX, &OutY, &OutWidth, &OutHeight

    x := ParsePosition(x, OutWidth)
    y := ParsePosition(y, OutHeight)

    MouseGetPos &xpos, &ypos
    Click x " " y
    MouseMove xpos, ypos
}

ParsePosition(value, dimension) {
    if InStr(value, "-") {
        parts := StrSplit(value, "-")
        valuePart := parts[1]
        offsetPart := parts[2]

        valueResult := ParseSinglePart(valuePart, dimension)
        offsetResult := ParseSinglePart(offsetPart, 0)

        result := valueResult - offsetResult
    }
    else {
        result := ParseSinglePart(value, dimension)
    }

    return result
}

ParseSinglePart(value, dimension) {
    if InStr(value, "%") {
        percentage := StrReplace(value, "%")
        result := (percentage / 100) * dimension
    }
    else if InStr(value, "px") {
        result := StrReplace(value, "px")
    }
    else {
        result := value
    }

    return result
}

MyWinMinimize() {
    WinMinimize("A")
}

MyWinMaximize() {
    try {
        winState := WinGetMinMax("A")
        if (winState = 0)
            WinMaximize("A")
        else if (winState = 1)
            WinRestore("A")
        else
            return
    }
}

WinActivateUnderCursor() {
    MouseGetPos(&x, &y, &id)
    if (id) {
        Sleep TIMEOUT
        try WinActivate("ahk_id " id)
    }
    else {
        return
    }
}

WinMinimizeUnderCursor() {
    MouseGetPos(&x, &y, &id)
    if (id) {
        Sleep TIMEOUT
        try WinMinimize("ahk_id " id)
    }
    else {
        return
    }
}

WinGetStateUnderCursor() {
    MouseGetPos(&x, &y, &id)
    if (id) {
        if (WinActive("ahk_id " id)) {
            return 1
        } else {
            return 0
        }
    }
}

WinCheckClassUnderCursor(targetClass) {
    MouseGetPos(&x, &y, &id)
    if (id) {

        className := WinGetClass("ahk_id " id)
        return (className = targetClass) ? true : false
    }
}

GetUrlRaw() {
    try {
        url := GetUrl("A")
        if (url) {
            return 1
        }
        else {
            return 0
        }
    }
    catch {
        return 0
    }
}

GetUrlValue(value) {
    MouseGetPos(&x, &y, &id, &control)
    try {
        url := GetUrl(id)
        if (RegExMatch(url, value)) {
            return 1
        }
        else {
            return 0
        }
    }
    catch {
        return -1
    }
}

GetUrlValueOnClick(value) {
    try {
        url := GetUrl("A")
        if (RegExMatch(url, value)) {
            return 1
        }
        else {
            return 0
        }
    }
    catch {
        return -1
    }
}

GetFocusedText(value) {
    MouseGetPos(&x, &y, &id, &control)
    try {
        Class := WinGetClass("ahk_id " id)
        FocusedText := ""
        if WinExist("ahk_id " id)
            FocusedText := ControlGetText(control)
        if (FocusedText = value) {
            return 1
        }
        else {
            return 0
        }
    }
    catch {
        return -1
    }
}

GetFocusedTextOnClick(value) {
    try {
        FocusedText := ControlGetText(ControlGetFocus("A"))
        if (FocusedText = value) {
            return 1
        }
        else {
            return 0
        }
    }
    catch {
        return -1
    }
}

GetClassNN(value) {
    MouseGetPos(&x, &y, &id, &control)
    try {
        ClassNN := ControlGetClassNN(control)
        if WinExist("ahk_id " id)
            if (ClassNN = value) {
                return 1
            }
            else {
                return 0
            }
    }
    catch {
        return -1
    }
}

GetClass(value) {
    MouseGetPos(&x, &y, &id, &control)
    try {
        Class := WinGetClass("ahk_id " id)
        if (Class = value) {
            return 1
        }
        else {
            return 0
        }
    }
    catch {
        return -1
    }
}

TitleMatch(value) {
    try {
        title := WinGetTitle("A")
        if (title ~= value) {
            return 1
        } else {
            return 0
        }
    }
    catch {
        return -1
    }
}

WinActivateAndClose(array) {
    for index, winTitle in array {
        if WinExist(winTitle) {
            WinActivate(winTitle)
            WinClose(winTitle)
        }
    }
}

toggleKeys := Map()
Toggle(key1, key2, reset := 0) {
    key := A_ThisHotkey

    if (!toggleKeys.Has(key)) {
        toggleKeys.Set(key, 1)
    }

    toggleKeys[key] := !toggleKeys[key]

    if (toggleKeys[key]) {
        if (!reset) {
            Send(key1)
        }
        else {
            Send(key2)
        }
    }
    else {
        if (reset) {
            Send(key1)
            ; Reset all values except the current key
            for k, v in toggleKeys {
                if (k != key) {
                    toggleKeys[k] := 1
                }
            }
        }
        else {
            Send(key2)
            ; Reset all values except the current key
            for k, v in toggleKeys {
                if (k != key) {
                    toggleKeys[k] := 1
                }
            }
        }
    }
}

ClassNN(value) {
    try {
        ClassNN := ControlGetClassNN(ControlGetFocus("A"))
        if (ClassNN = value) {
            return 1
        }
        else {
            return 0
        }
    }
    catch {
        return -1
    }
}

NotClassNN(value) {
    try {
        ClassNN := ControlGetClassNN(ControlGetFocus("A"))
        if (ClassNN = value) {
            return 0
        }
        else {
            return 1
        }
    }
    catch {
        return -1
    }
}

FocusedText(value) {
    try {
        FocusedText := ControlGetText(ControlGetFocus("A"))
        if (FocusedText = value) {
            return 1
        }
        else {
            return 0
        }
    }
    catch {
        return -1
    }
}
