#cs ----------------------------------------------------------------------------

 AutoIt Version: 3.3.6.1
 Author:         myName

 Script Function:
	Template AutoIt script.

#ce ----------------------------------------------------------------------------

#AutoIt3Wrapper_UseX64=n

#include <MsgBoxConstants.au3>
#include <ImageSearch.au3>
WinActivate ("Badoo")
Sleep(1000)

HotKeySet("{ESC}", "Terminate")

Func Terminate()
    Exit
EndFunc

$likeFile = "like.bmp" 


$i = 0

While $i <= 100
	WinActivate ("Badoo")
	If WinActive("Badoo") Then
		$searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, $likeFile, 10)
		If $searchResult[0] <> -1 Then
			ConsoleWrite("Using " & ": " & $searchResult[0] & ", "& $searchResult[1] & @CRLF)
			MouseMove($searchResult[0],$searchResult[1],0)
			MouseClick("left")
			MouseMove(0,0,0)
			Sleep(1000)
		EndIf 
		$searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, "Badoo_close.png", 10)
		If $searchResult[0] <> -1 Then
			ConsoleWrite("Using " & ": " & $searchResult[0] & ", "& $searchResult[1] & @CRLF)
			MouseMove($searchResult[0],$searchResult[1],0)
			MouseClick("left")
			Sleep(1000)
		EndIf 
		$searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, "Badoo_connect.png", 10)
		If $searchResult[0] <> -1 Then
			ConsoleWrite("Using " & ": " & $searchResult[0] & ", "& $searchResult[1] & @CRLF)
			MouseMove($searchResult[0],$searchResult[1],0)
			MouseClick("left")
			Sleep(1000)
		EndIf 
		
		Sleep(10000)
	Endif
WEnd

	