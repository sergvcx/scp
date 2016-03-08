
#include <MsgBoxConstants.au3>
while 1 
	;if WinExists ( "TeamViewer_Desktop") Then
	;	WinActivate ("TeamViewer_Desktop")
	;	Sleep(500)
	;	Send("{ENTER}") 
	;Endif 
	;---------------------------
	if WinExists ( "Спонсируемый сеанс") Then
		WinActivate ("Спонсируемый сеанс")
		Sleep(500)
		Send("{ENTER}") 
	Endif 
	;-------------------------
	if WinExists ( "Достигнут лимит") Then
		WinActivate ("Достигнут лимит")
		Sleep(500)
		Send("{ENTER}") 
	Endif 
	;-------------------------
	if WinExists ( "TeamViewer - журнал регистрации") Then
		WinActivate ("TeamViewer - журнал регистрации")
		Sleep(500)
		ControlClick ("TeamViewer - журнал регистрации","","Закрыть") 
	Endif 
	;-------------------------
	;Local $hWnd = WinActive("[CLASS:CNotificationWindow]")
	If WinExists ( "[CLASS:CNotificationWindow]"  )  Then 
		WinClose("[CLASS:CNotificationWindow]")
	Endif 
	Sleep(5000)
WEnd


    