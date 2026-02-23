#Requires AutoHotkey >=v2.0
#SingleInstance Force
KeyHistory(0)

    c:: {
        Text := ""
        FocusedText := ControlGetText(ControlGetFocus("A"))
        A_Clipboard := FocusedText
        Text .= "Value copied to Clipboard: `n" FocusedText 
        Result := MsgBox(Text)
        if Result = "Ok"
            ExitApp
    }

    Escape:: {
    ExitApp
    }