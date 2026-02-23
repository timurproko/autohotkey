SetFormat, Integer, Hex 
Gui +ToolWindow -SysMenu +AlwaysOnTop 
Gui, Font, s14 Bold, Arial 
Gui, Add, Text, w250 h33 vSC 0x201 +Border, SCCODE VKCODE 
Gui, Show

Loop 9 
	OnMessage( 255+A_Index, "ScanCode" )    ;     0x100 to 0x108 
Return 


ScanCode( wParam, lParam )
{ 
	VKCODE := wParam 
	SCCODE := SubStr( ((( lParam>>16) & 0xFF)+0xF000),-2) 
	GuiControl,, SC, VK %VKCODE% SC %SCCODE%  
}