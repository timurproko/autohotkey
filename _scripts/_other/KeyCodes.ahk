#Requires AutoHotkey v2.0
#SingleInstance Force

dlg := Gui("+ToolWindow +AlwaysOnTop", "Key Codes")
dlg.SetFont("s16 Bold", "Arial")

keyNameTxt := dlg.Add("Text", "w300 h40 0x201 +Border Center", "Press any Key…")
scTxt := dlg.Add("Text", "w300 h40 0x201 +Border Center", "Click to Copy")

scTxt.OnEvent("Click", (ctrl, *) => (
    (SubStr(ctrl.Text, 1, 3) = "SC ")
        ? (
            A_Clipboard := "sc" . StrLower(StrReplace(ctrl.Text, "SC ")),
            ToolTip("Copied: " A_Clipboard),
            SetTimer(() => ToolTip(), -900)
        )
        : ""
))

dlg.OnEvent("Close", (*) => ExitApp())
dlg.Show()

for msg in [0x100, 0x104]  ; WM_KEYDOWN, WM_SYSKEYDOWN
    OnMessage(msg, ShowScan.Bind(keyNameTxt, scTxt))

ShowScan(keyNameCtrl, scCtrl, wParam, lParam, msg, hwnd) {
    vk := wParam
    sc := (lParam >> 16) & 0xFF

    name := GetKeyName(Format("sc{:02X}", sc))
    if !name
        name := GetKeyName(Format("vk{:02X}", vk))

    keyNameCtrl.Text := name
    scCtrl.Text := "SC " . Format("{:03X}", sc)
}
