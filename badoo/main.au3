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

$searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, $likeFile, 10)
If $searchResult[0] <> -1 Then
	ConsoleWrite("Using " & ": " & $searchResult[0] & ", "& $searchResult[1] & @CRLF)
	MouseMove($searchResult[0],$searchResult[1],0)
	Sleep(1000)
EndIf 

$i = 0

While $i <= 100
	If WinActive("Badoo") Then
		MouseClick("left")
		Sleep(60000)
	Endif
WEnd

	