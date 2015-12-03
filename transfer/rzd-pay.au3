;#include "typewriter.au3"
WinActivate ("Расписание")



    
;    For $i = 1 To $aNum[0] ; Loop through the array returned by StringSplit to display the individual values.
;        MsgBox($MB_SYSTEMMODAL, "", "$aNum[" & $i & "] - " & $aNum[$i])
;    Next

	


;Exit(0)

$ini = "hkb.ini"
$section = "hkb"
$card = IniRead ( $ini, $section, "card", "" )

Local $aNum = StringSplit($card, " ") 
; MsgBox($MB_SYSTEMMODAL, "", "The value of 'Title' in the section labelled 'General' is: " & $card)

Sleep(200)
Send($aNum[1]) 
Sleep(100)
Send($aNum[2])
Sleep(100)
Send($aNum[3]) 
Sleep(100)
Send($aNum[4]) 
Sleep(100)
;Send("{TAB}")
Send($aNum[5])
Sleep(100)
;Send("{TAB}") 
Send($aNum[6])

Sleep(100)
;Send("{TAB}") 
Send($mail)
;Send(SERGEY MUSHKAEV)


;Send("{TAB}{TAB}") 

;EndFunc   ;==>TestFunc1


;TcsCard2Card("tel.ini","serg8881")
