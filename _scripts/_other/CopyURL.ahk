#Requires AutoHotkey >=v2.0
#Include D:\Dropbox\Configs\AutoHotkey\Functions\GetUrl.ahk
#SingleInstance Force
KeyHistory(0)

c:: {
    url := GetUrl("A")
    ; regex := "https:\/\/(.*?)(\/|$)"
    ; url_end := RegExReplace(url_raw, regex, "")
    ; url := RegExReplace(url_raw, url_end, "")
    
    if (url) {
        A_Clipboard := url
        Text .= "Value copied to Clipboard: `n" url 
        Result := MsgBox(Text)
        if Result = "Ok"
            ExitApp
    } else {
        MsgBox("Couldn't retrieve an URL from the active window.", "Error", 0x40010)
    }
}

Escape:: {
ExitApp
}