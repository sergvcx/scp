

    
;    For $i = 1 To $aNum[0] ; Loop through the array returned by StringSplit to display the individual values.
;        MsgBox($MB_SYSTEMMODAL, "", "$aNum[" & $i & "] - " & $aNum[$i])
;    Next

	


;Exit(0)

Func TcsCard2Card($ini,$section)
$card = IniRead ( $ini, $section, "card", "0000-0000-0000-0000" )
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
Send("{TAB}")
Send($aNum[5])
Sleep(100)
Send("{TAB}") 
Send($aNum[6])
Send("{TAB}{TAB}") 

EndFunc   ;==>TestFunc1
