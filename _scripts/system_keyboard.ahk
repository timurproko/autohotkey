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

#HotIf GetKeyboardLanguage(en)
!sc00C:: Send("{U+2013}") ; –
sc02B:: Send("{U+005C}") ; \
+sc02B:: Send("{U+007C}") ; |
#HotIf

#HotIf GetKeyboardLanguage(ru) || GetKeyboardLanguage(ua)
+sc002:: Send("{U+0021}") ; !
!sc002:: Send("{U+0021}") ; !
+sc003:: Send("{U+0022}") ; "
!sc003:: Send("{U+0040}") ; @
+sc004:: Send("{U+2116}") ; №
!sc004:: Send("{U+0023}") ; #
+sc005:: Send("{U+0025}") ; %
!sc005:: Send("{U+0024}") ; $
+sc006:: Send("{U+003A}") ; :
!sc006:: Send("{U+0025}") ; %
+sc007:: Send("{U+002C}") ; ,
!sc007:: Send("{U+005E}") ; ^
+sc008:: Send("{U+002E}") ; .
!sc008:: Send("{U+0026}") ; &
+sc009:: Send("{U+003B}") ; ;
!sc009:: Send("{U+002A}") ; *
+sc00A:: Send("{U+0028}") ; (
!sc00A:: Send("{U+007B}") ; {
+sc00B:: Send("{U+0029}") ; )
!sc00B:: Send("{U+007D}") ; }
!sc00C:: Send("{U+2013}") ; –
!sc00D:: Send("{U+00BB}") ; »
sc035:: Send("{U+002F}") ; /
+sc035:: Send("{U+003F}") ; ?
!sc035:: Send("{U+201C}") ; “
sc029:: Send("{U+005D}") ; ]
+sc029:: Send("{U+005B}") ; [
!sc028:: Send("{U+0027}") ; ’
!sc029:: Send("{U+0060}") ; `
sc056:: Send("{U+003E}") ; >
+sc056:: Send("{U+003C}") ; <
!sc056:: Send("{U+00A7}") ; §
!sc033:: Send("{U+2264}") ; ≤
!sc034:: Send("{U+2265}") ; ≥
!sc01A:: Send("{U+201C}") ; “
!sc027:: Send("{U+2026}") ; …
#HotIf

#HotIf GetKeyboardLanguage(ru)
sc02B:: Send("{U+0451}") ; ё
+sc02B:: Send("{U+0401}") ; Ё
#HotIf

#HotIf GetKeyboardLanguage(ua)
sc01F:: Send("{U+0438}") ; и
+sc01F:: Send("{U+0418}") ; И
sc030:: Send("{U+0456}") ; і
+sc030:: Send("{U+0406}") ; І
sc01B:: Send("{U+0457}") ; ї
+sc01B:: Send("{U+0407}") ; Ї
sc02B:: Send("{U+0491}") ; ґ
+sc02B:: Send("{U+0490}") ; Ґ
#HotIf

; Functional Keys
#f7:: Send("#!k")
#f8:: SendInput("{Media_Prev}")
#f9:: SendInput("{Media_Play_Pause}")
#f10:: SendInput("{Media_Next}")
#f11:: SendInput("{Volume_Mute}")
#f12:: SendInput("{Volume_Down}")
#f13:: SendInput("{Volume_Up}")
f13:: Send("{Insert}")
f14:: Send("{Scrolllock}")
f15:: Send("{Pause}")

; Backspace for Delete
#Backspace:: Send("{Delete}")

; Remap Delete for Small Keyboard
#sc00e::sc053