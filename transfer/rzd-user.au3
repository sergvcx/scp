WinActivate ("Расписание")

#include <MsgBoxConstants.au3>

$ini       = "pass.ini"
$section   = "sergey"
$name      = IniRead ( $ini, $section, "name", "" )



$surname   = IniRead ( $ini, $section, "surname", "" )
$middlename= IniRead ( $ini, $section, "middlename", "" )
$passport  = IniRead ( $ini, $section, "passport", "" )
$sex       = IniRead ( $ini, $section, "sex", "" )
$birthday  = IniRead ( $ini, $section, "birthday", "" )
$bonus     = IniRead ( $ini, $section, "bonus", "" )


MsgBox($MB_SYSTEMMODAL, "", "name is: " & $birthday)



Sleep(200)
Send($surname)
Send("{TAB}") 

Sleep(200)
Send($name)
Send("{TAB}") 

Sleep(200)
Send($middlename)
Send("{TAB}") 
Sleep(200)
Send("{TAB}") 
Sleep(200)
Send("{TAB}")

Sleep(100)
Send($passport)
Send("{TAB}")


If $sex = "m" Then
	Send("{DOWN}")
	Send("{DOWN}")
ElseIf
	Send("{DOWN}")
Endif

Send("{TAB}")
Send("{TAB}")


Sleep(100)
Send($birthday) 
Sleep(100)
Send("{TAB}")
Send("{ENTER}")
