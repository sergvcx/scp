;#include "typewriter.au3"
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>


WinActivate ("Платежи и переводы")



$ini = "alfa.ini"
$section = "virtual"
$card  = IniRead ( $ini, $section, "card", "" )
$name  = IniRead ( $ini, $section, "name", "" )
$month = IniRead ( $ini, $section, "month", "" )
$year  = IniRead ( $ini, $section, "year", "" )
$ccc   = IniRead ( $ini, $section, "ccc", "" )
Local $aNum = StringSplit($card, " ") 

$card  = StringStripWS($card, $STR_STRIPALL )

 ;MsgBox($MB_SYSTEMMODAL, "", "The value of 'Title' in the section labelled 'General' is: " & $card)
 ;MsgBox($MB_SYSTEMMODAL, "", "year: " & $year)
;MsgBox($MB_SYSTEMMODAL, "", "The value of 'Title' in the section labelled 'General' is: " & $aNum[1] )
Sleep(400)
Send($card) 
Sleep(400)
;Send("{TAB}") 
Sleep(400)
Send($month)
Sleep(400)
Send($year)
Sleep(400)
Send($ccc)


