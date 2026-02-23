#Requires AutoHotkey >=v2.0

; Retrieve all windows on the current desktop
HWNDs := WinGetList()

; Iterate through each window and display its details
for hwnd in HWNDs
{
    ; Get the window's title and class
    WinTitle := WinGetTitle(hwnd)
    WinClass := WinGetClass(hwnd)
    WinStyle := WinGetExStyle(hwnd)
    WinPID := WinGetPID(hwnd)
    
    ; Display the window's information with a Cancel button
    Result := MsgBox(
    (
        "Window Handle (HWND): " hwnd "`n"
        "Window Title: " WinTitle "`n"
        "Window Class: " WinClass "`n"
        "Window Extended Style: " WinStyle "`n"
        "Window PID: " WinPID "`n`n"
        "Continue to the next window?"
    ), "Process Inspector", 1)
    
    ; Handle the response
    if (Result = "No")
        continue ; Skip to the next window
    else if (Result = "Cancel")
        ExitApp ; Exit the script
}
