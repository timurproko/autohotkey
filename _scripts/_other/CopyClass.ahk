#Requires AutoHotkey >=v2.0
#SingleInstance Force
KeyHistory(0)

    c:: {
        Text := ""
        MouseGetPos(&x, &y, &id, &control)
        Class := WinGetClass("ahk_id " id)
        A_Clipboard := Class
        Text .= "Value copied to Clipboard: `n" Class
        Result := MsgBox(Text)
        if Result = "Ok"
            ExitApp
    }

    Escape:: {
    ExitApp
    }