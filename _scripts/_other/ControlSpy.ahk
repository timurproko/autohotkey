#Requires AutoHotkey >=v2.0
#SingleInstance Force
Persistent
SetTimer(WatchCursor, 250)
Return

WatchCursor()
{
    MouseGetPos(&x, &y, &id, &control)
    title := WinGetTitle("ahk_id " id)
    ClassNN := WinGetClass("ahk_id " id)
    FocusedText := ""

    if WinExist("ahk_id " id) {
        if (control != "")
                FocusedText := ControlGetText(control)
        } else {
            control := ""
            class := ""
        }

    ToolTip(
        "Xpos = " x
        "`nYpos = " y
        ; "`n"
        ; "`nahk_id: " id 
        ; "`nahk_class: " class 
        "`n" 
        "`nClassNN: " ClassNN 
        "`nText: " FocusedText 
        )
    Return
}

    Escape:: {
        ExitApp
    }