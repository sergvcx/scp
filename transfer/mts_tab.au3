;#include "typewriter.au3"
;WinActivate ("Chrome")
;$browser = "Chrome"

Local $hWnd = WinWait("[CLASS:Chrome_WidgetWin_1]", "", 10)
; Activate the Notepad window using the handle returned by WinWait.
WinActivate($hWnd)

	
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include "keyboard.au3"
;https://pay.mts.ru/webportal/payments/3565/Moskva


$section   = "mts"

$ini = "plastic.ini"
$card  = IniRead ( $ini, $section, "card", "" )
$name  = IniRead ( $ini, $section, "name", "" )
$month = IniRead ( $ini, $section, "month", "" )
$year  = IniRead ( $ini, $section, "year", "" )
$ccc   = IniRead ( $ini, $section, "ccc", "" )
$mail  = IniRead ( $ini, $section, "mail", "" )
$card  = StringStripWS($card, $STR_STRIPALL )


Sleep(200)
Send($card) 
Send("{TAB}")
Send($month)
Sleep(100)
Send($year)
Sleep(100)
Send($ccc)

