$browser = "Расписание"
if WinActivate ($browser)= 0 Then
	MsgBox($MB_SYSTEMMODAL, "", "Бразуер с РЖД не найден " )
	exit
Endif	


#include <MsgBoxConstants.au3>
#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>


#include <GUIConstantsEx.au3>
#include <MsgBoxConstants.au3>
#include "keyboard.au3"

;Example()

	
Func Example()
    ; Create a GUI with various controls.
    Local $hGUI = GUICreate("Example", 300, 200)

    ; Create a combobox control.
    Local $idComboBox = GUICtrlCreateCombo("Item 1", 10, 10, 185, 20)
    Local $idClose = GUICtrlCreateButton("Close", 210, 170, 85, 25)

    ; Add additional items to the combobox.
    GUICtrlSetData($idComboBox, "Item 2|Item 3", "Item 2")
	GUICtrlSetData($idComboBox, "Item 4", "Item 4-4")

    ; Display the GUI.
    GUISetState(@SW_SHOW, $hGUI)

    Local $sComboRead = ""

    ; Loop until the user exits.
    While 1
        Switch GUIGetMsg()
            Case $GUI_EVENT_CLOSE, $idClose
                ExitLoop

            Case $idComboBox
                $sComboRead = GUICtrlRead($idComboBox)
                MsgBox($MB_SYSTEMMODAL, "", "The combobox is currently displaying: " & $sComboRead, 0, $hGUI)

        EndSwitch
    WEnd

    ; Delete the previous GUI and all controls.
    GUIDelete($hGUI)
EndFunc   ;==>Example



$ini       = "pass.ini"
$section   = "sergey"

$who = InputBox( "Choose Power Plan", "1: Сергей "& @CRLF & "2: Папа "& @CRLF &  "3: Мама " )

Switch $who
	Case 1
		$section   = "sergey"
	Case 2
		$section   = "papa"
	Case 3
		$section   = "mama"
EndSwitch
   
$name      = IniRead ( $ini, $section, "name", "" )



$surname   = IniRead ( $ini, $section, "surname", "" )
$middlename= IniRead ( $ini, $section, "middlename", "" )
$passport  = IniRead ( $ini, $section, "passport", "" )
$sex       = IniRead ( $ini, $section, "sex", "" )
$birthday  = IniRead ( $ini, $section, "birthday", "" )
$bonus     = IniRead ( $ini, $section, "bonus", "" )


	

;MsgBox($MB_SYSTEMMODAL, "", "name is: " & $RU)
;exit 

$hWnd=WinGetHandle ($browser)
$lang=_WinAPI_GetKeyboardLayout($hwnd);
;MsgBox($MB_SYSTEMMODAL, "", "Ru/En" & $lang )
if $lang = $RU Then
	;MsgBox($MB_SYSTEMMODAL, "", "Ru->En" )
	_WinAPI_SetKeyboardLayout($EN, $hWnd)
Endif	



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
Else
	Send("{DOWN}")
Endif

Send("{TAB}")
Send("{TAB}")


Sleep(100)
Send($birthday) 
Sleep(100)
Send("{TAB}")
Send("{ENTER}")

Sleep(1000)
;WinGetActiveStats, getTitle, width, height, x, y
;MouseGetPos, cur_x, cur_y 
;center_x:=x+width/2
;center_y:=y+height/2
;MouseMove,center_x,center_y,

