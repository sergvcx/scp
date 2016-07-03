;#include "typewriter.au3"

#include <MsgBoxConstants.au3>
#include <StringConstants.au3>
#include <Clipboard.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <Array.au3>
    
;MsgBox(0,"test",@ScriptDir & @CRLF & @WorkingDir)
FileChangeDir ( @ScriptDir )
	
$Windows = WinList()

For $I = 1 to $Windows[0][0]
   If StringInStr($Windows[$I][0], "Chrome") Then
      WinActivate($Windows[$I][0])
   EndIf
Next

$who = InputBox( "Choose plastic", "1: МТС "& @CRLF & "2: Хоум " )

Switch $who
	Case 1
		$section   = "mts"
	Case 2
		$section   = "hkb"
EndSwitch
   
$ini = "plastic.ini"
$card  = IniRead ( $ini, $section, "card", "" )
$name  = IniRead ( $ini, $section, "name", "" )
$surname  = IniRead ( $ini, $section, "surname", "" )
$month = IniRead ( $ini, $section, "month", "" )
$year  = IniRead ( $ini, $section, "year", "" )
$ccc   = IniRead ( $ini, $section, "ccc", "" )
$mail  = IniRead ( $ini, $section, "mail", "" )

$name = $name & " " & $surname

$card  = StringStripWS($card, $STR_STRIPALL )
Local $cardArray = StringSplit($card,"")

;_ArrayDisplay($cardArray)
For $i =1 to 16 Step 1 
	Send($cardArray[$i]) 
	Sleep(100)
Next

For $i =1 to 10 Step 1 
	$who = InputBox( "Date: " & $month & "/" & $year , "1: Name"& @CRLF & "2: сvv" & @CRLF & "3: mail" & @CRLF & "0: exit" )
	Switch $who
		Case 0
			Exit
		Case 1
			Send($name)  
		Case 2
			Send($ccc)  
		Case 3
			Send($mail)  
	EndSwitch
Next

