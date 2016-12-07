;#include "typewriter.au3"
WinActivate ("TW")

#include <MsgBoxConstants.au3>
#include <StringConstants.au3>

    
;    For $i = 1 To $aNum[0] ; Loop through the array returned by StringSplit to display the individual values.
;        MsgBox($MB_SYSTEMMODAL, "", "$aNum[" & $i & "] - " & $aNum[$i])
;    Next

	


;Exit(0)

$ini = "plastic.ini"
$section = "hkb"
$card  = IniRead ( $ini, $section, "card", "" )
$name  = IniRead ( $ini, $section, "name", "" )
$surname  = IniRead ( $ini, $section, "surname", "" )
$month = IniRead ( $ini, $section, "month", "" )
$year  = IniRead ( $ini, $section, "year", "" )
$ccc   = IniRead ( $ini, $section, "ccc", "" )

$card  = StringStripWS($card, $STR_STRIPALL )



;Local $aNum = StringSplit($card, " ") 
; MsgBox($MB_SYSTEMMODAL, "", "The value of 'Title' in the section labelled 'General' is: " & $card)
; MsgBox($MB_SYSTEMMODAL, "", "year: " & $year)

Sleep(200)
Send($card) 
Send("{TAB}") 
Sleep(100)

Send($month) 
Send($year) 



Send("{TAB}") 
Sleep(100)
Send($name)
Send(" ")
Send($surname)

Send("{TAB}") 
Send($ccc)

;Send($aNum[2])
;Sleep(100)
;Send($aNum[3]) 
;Sleep(100)
;Send($aNum[4]) 
;Sleep(100)
;
;
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

;For $y = 16 To $year Step 1
;    Send("{DOWN}") 
;	Sleep(100)
;Next
;Sleep(100)
;Send($ccc)
;Send("{TAB}") 


;Send("{TAB}") 
;Sleep(100)
