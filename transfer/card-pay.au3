;#include "typewriter.au3"
;WinActivate ("Chrome")
#include "../msg.au3"
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>


$ini = "plastic.ini"
$section = "mts"
$card  = IniRead ( $ini, $section, "card", "" )
$name  = IniRead ( $ini, $section, "name", "" )
$month = IniRead ( $ini, $section, "month", "" )
$year  = IniRead ( $ini, $section, "year", "" )
$ccc   = IniRead ( $ini, $section, "ccc", "" )

$card4 = StringSplit($card, " ") 
$card16= StringStripWS($card, $STR_STRIPALL )




; MsgBox($MB_SYSTEMMODAL, "", "The value of 'Title' in the section labelled 'General' is: " & $card)
; MsgBox($MB_SYSTEMMODAL, "", "year: " & $year)
MSG_MODAL("Waring","Переключись на нужное окно и установи курсор",10)
Sleep(200)
Send($card4[1]) 
Sleep(200)
Send($card4[2]) 
Sleep(200)
Send($card4[3]) 
Sleep(200)
Send($card4[4]) 
Send("{TAB}") 

Sleep(200)
Send($month) 

Sleep(200)
Send($year) 

Sleep(200)
Send($ccc) 


;Send($aNum[2])
;Sleep(100)
;Send($aNum[3]) 
;Sleep(100)
;Send($aNum[4]) 
;Sleep(100)
;
;Sleep(100)
;Send($ccc)
;Send("{TAB}") 
;;
;Sleep(100)
;Send($name)
;Send("{TAB}") 
;Sleep(100)
;For $m = 1 To $month Step 1
;    Send("{DOWN}") 
;	Sleep(100)
;Next
;Sleep(100)
;Send("{TAB}") 
;Sleep(100)
;
;For $y = 16 To $year Step 1
;    Send("{DOWN}") 
;	Sleep(100)
;Next

;Send("{TAB}") 
;Sleep(100)
