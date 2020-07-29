; Joe Winograd, 26-Aug-2018
; Alt+RightArrow || Alt+LeftArrow to increase/decrease volume
#Warn,UseUnsetLocal
#NoEnv
#SingleInstance force
SetBatchLines,-1

; change these three value to whatever you want
BarWidth:=800
BarHeight:=20
BarColor:="Blue"
BarMillisecondsToStayOnScreen:=3000 ; 3 seconds

ProgramName:=A_ScriptName
StringTrimRight,ProgramName,ProgramName,4 ; remove .ahk or .exe
SoundGet,Volume
Volume:=Round(Volume)
TrayTip:="Alt+LeftArrow or Alt+RightArrow to adjust volume" . "`nCurrent Volume=" . Volume
TrayIconFile:=A_WinDir . "\System32\DDORes.dll" ; get tray icon from DDORes.dll
TrayIconNum:="-2032" ; use headphones as tray icon (icon 2032 in DDORes)
Menu,Tray,Tip,%TrayTip%
Menu,Tray,Icon,%TrayIconFile%,%TrayIconNum%
Gui,+ToolWindow -SysMenu
Gui,Add,Progress,w%BarWidth% h%BarHeight% c%BarColor% vBarVal
Gui,Hide
Return ; end auto-execute

!Left::
SetTimer,SliderOff,%BarMillisecondsToStayOnScreen%
SoundSet,-1
Gosub,DisplaySlider
Return

!Right::
SetTimer,SliderOff,%BarMillisecondsToStayOnScreen%
SoundSet,+1
Gosub,DisplaySlider
Return

SliderOff:
Gui,Hide
Return

DisplaySlider:
SoundGet,Volume
Volume:=Round(Volume)
Title:=ProgramName . "     Current Volume=" . Volume
Gui,Show,,%Title%
GuiControl,,BarVal,%Volume%
TrayTip:="Alt+LeftArrow or Alt+RightArrow to adjust volume" . "`nCurrent Volume=" . Volume
Menu,Tray,Tip,%TrayTip%
Return
