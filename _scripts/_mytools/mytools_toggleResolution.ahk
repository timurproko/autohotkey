; AutoHotkey v2 script: toggle selected monitor 2K <-> 4K
; Requires AutoHotkey v2.x
;
; Launch behavior:
; - Checks current resolution of selected monitor
; - If current is 2K, switches to 4K
; - If current is 4K, switches to 2K
; - Then exits

#Requires AutoHotkey v2.0
#SingleInstance Force

; ---- configuration ----

MonitorNumber := 6
DeviceName := "\\.\DISPLAY" MonitorNumber

; Your "2K" fallback mode
W2K := 1920
H2K := 1080
TargetHz2K := 60

; 4K mode
W4K := 3840
H4K := 2160
TargetHz4K := 60

BitsPerPixel := 32

; ---- run once and close ----

Toggle()
ExitApp


Toggle() {
    global W2K, H2K, W4K, H4K, TargetHz2K, TargetHz4K

    cur := GetCurrentResolution()

    if (!cur) {
        MsgBox("Could not read current resolution for selected display.", "Toggle Resolution", 0x10)
        return
    }

    if (cur.w = W4K && cur.h = H4K) {
        SetResolution(W2K, H2K, TargetHz2K)
    }
    else if (cur.w = W2K && cur.h = H2K) {
        SetResolution(W4K, H4K, TargetHz4K)
    }
    else {
        ; If current resolution is something else, default to 4K
        SetResolution(W4K, H4K, TargetHz4K)
    }
}


GetCurrentResolution() {
    global DeviceName

    ; DEVMODEW struct
    dmSize := 220
    DM := Buffer(dmSize, 0)

    ; dmSize offset for DEVMODEW
    NumPut("UShort", dmSize, DM, 68)

    ENUM_CURRENT_SETTINGS := -1

    ok := DllCall("user32\EnumDisplaySettingsExW"
        , "Str", DeviceName
        , "Int", ENUM_CURRENT_SETTINGS
        , "Ptr", DM.Ptr
        , "UInt", 0
        , "Int")

    if (!ok) {
        return false
    }

    ; DEVMODEW offsets:
    ; dmPelsWidth  = 172
    ; dmPelsHeight = 176
    ; dmDisplayFrequency = 184
    w := NumGet(DM, 172, "UInt")
    h := NumGet(DM, 176, "UInt")
    hz := NumGet(DM, 184, "UInt")

    return { w: w, h: h, hz: hz }
}


SetResolution(width, height, hz) {
    global DeviceName, BitsPerPixel

    ; DEVMODEW struct
    dmSize := 220
    DM := Buffer(dmSize, 0)

    ; dmSize at offset 68
    NumPut("UShort", dmSize, DM, 68)

    ; dmFields offset 72
    ; DM_BITSPERPEL        = 0x40000
    ; DM_PELSWIDTH         = 0x80000
    ; DM_PELSHEIGHT        = 0x100000
    ; DM_DISPLAYFREQUENCY  = 0x400000
    fields := 0x40000 | 0x80000 | 0x100000 | 0x400000
    NumPut("UInt", fields, DM, 72)

    ; DEVMODEW offsets
    NumPut("UInt", BitsPerPixel, DM, 168)
    NumPut("UInt", width,        DM, 172)
    NumPut("UInt", height,       DM, 176)
    NumPut("UInt", hz,           DM, 184)

    CDS_UPDATEREGISTRY := 0x01
    CDS_TEST := 0x02

    ; Test first
    test := DllCall("user32\ChangeDisplaySettingsExW"
        , "Str", DeviceName
        , "Ptr", DM.Ptr
        , "Ptr", 0
        , "UInt", CDS_TEST
        , "Ptr", 0
        , "Int")

    if (test != 0) {
        MsgBox(
            "Resolution change not supported." 
            . "`n`nDisplay: " DeviceName
            . "`nRequested: " width "x" height " @ " hz "Hz"
            . "`nError code: " test,
            "Toggle Resolution",
            0x10
        )
        return
    }

    ; Apply
    res := DllCall("user32\ChangeDisplaySettingsExW"
        , "Str", DeviceName
        , "Ptr", DM.Ptr
        , "Ptr", 0
        , "UInt", CDS_UPDATEREGISTRY
        , "Ptr", 0
        , "Int")

    if (res = 0) {
        return
    } else {
        MsgBox(
            "Resolution change failed."
            . "`n`nDisplay: " DeviceName
            . "`nRequested: " width "x" height " @ " hz "Hz"
            . "`nError code: " res,
            "Toggle Resolution",
            0x10
        )
    }
}