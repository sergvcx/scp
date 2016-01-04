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
Sleep(100)
Send($aNum[1]) 
Sleep(100)
Send($aNum[2]) 
Sleep(100)
Send($aNum[3]) 
Sleep(100)
Send($aNum[4]) 
Sleep(500)
Send("{TAB}") 

Sleep(100)
Send($month)

Sleep(100)
Send($year)
Send("{TAB}") 
Sleep(100)
Send($ccc)

Send("{TAB}") 
Send("{TAB}") 

