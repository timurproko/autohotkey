#Requires AutoHotkey v2.0
#SingleInstance Force

list := ""

Loop 10 {
    deviceName := "\\.\DISPLAY" A_Index

    dmSize := 220
    DM := Buffer(dmSize, 0)
    NumPut("UShort", dmSize, DM, 68)

    ok := DllCall("user32\EnumDisplaySettingsExW"
        , "Str", deviceName
        , "Int", -1
        , "Ptr", DM.Ptr
        , "UInt", 0
        , "Int")

    if (ok) {
        w := NumGet(DM, 172, "UInt")
        h := NumGet(DM, 176, "UInt")
        hz := NumGet(DM, 184, "UInt")

        list .= deviceName " = " w "x" h " @ " hz "Hz`n"
    }
}

MsgBox(list, "Detected Displays")