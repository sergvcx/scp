;#include "typewriter.au3"
WinActivate ("MTC")
#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
;https://pay.mts.ru/webportal/payments/3565/Moskva



    
;    For $i = 1 To $aNum[0] ; Loop through the array returned by StringSplit to display the individual values.
;        MsgBox($MB_SYSTEMMODAL, "", "$aNum[" & $i & "] - " & $aNum[$i])
;    Next

	


;Exit(0)

$choice = InputBox( "Choose telephone", "1: Сергей 8881"& @CRLF & "2: Папа "& @CRLF &  "3: Мама 0222" )

Switch $choice
	Case 1
		$section   = "serg8881"
	Case 2
		$section   = "papa"
	Case 3
		$section   = "mama0222"
EndSwitch

$ini = "tel.ini"
$tel = IniRead ( $ini, $section, "tel", "" )
;MsgBox($MB_SYSTEMMODAL, "", "tel=" & $tel)
;-------------------------------------------------------------------
$choice = InputBox( "Choose card", "1: tcs-Сергей"& @CRLF & "2: tcs-Папа ")

Switch $choice
	Case 1
		$section   = "tcs-serg"
	Case 2
		$section   = "tcs-papa"
EndSwitch


$ini = "plastic.ini"
$card  = IniRead ( $ini, $section, "card", "" )
$name  = IniRead ( $ini, $section, "name", "" )
$month = IniRead ( $ini, $section, "month", "" )
$year  = IniRead ( $ini, $section, "year", "" )
$ccc   = IniRead ( $ini, $section, "ccc", "" )
$mail  = IniRead ( $ini, $section, "mail", "" )
$card  = StringStripWS($card, $STR_STRIPALL )

;MsgBox($MB_SYSTEMMODAL, "", "card=" & $card)
;Local $aNum = StringSplit($card, " ") 
;MsgBox($MB_SYSTEMMODAL, "", "The value of 'Title' in the section labelled 'General' is: " & $card)

Sleep(200)
Send($tel) 
Sleep(1000)

Send("100")
Sleep(1000)

Send($card) 
Sleep(100)

Send($month) 
Sleep(500)

Send($year)
Sleep(500)

Send($ccc)
Sleep(500)

Send($mail)
Sleep(500)

;Send("{TAB}") 



;Send("{TAB}{TAB}") 

;EndFunc   ;==>TestFunc1


;TcsCard2Card("tel.ini","serg8881")
