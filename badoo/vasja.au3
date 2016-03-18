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

Func PressLike()
    $searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, "like.bmp" , 10)
	If $searchResult[0] <> -1 Then
		MouseMove($searchResult[0],$searchResult[1],0)
		Sleep(500)
		MouseClick("left")
		MouseMove(0,0,0)
		Sleep(500)
	EndIf 
EndFunc

Func PressDislike()
    $searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, "Badoo_dislike.png" , 10)
	If $searchResult[0] <> -1 Then
		MouseMove($searchResult[0],$searchResult[1],0)
		Sleep(500)
		MouseClick("left")
		MouseMove(0,0,0)
		Sleep(500)
	EndIf 
EndFunc



$likeFile = "like.bmp" 


$i = 0

While $i <= 100
	WinActivate ("Badoo")
	If WinActive("Badoo") Then
	
		
		$searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, "Badoo_profile.png", 10)
		If $searchResult[0] <> -1 Then
			Sleep(Random(1000,5000))
			MouseMove($searchResult[0],$searchResult[1],0)
			MouseClick("left")
			
			$searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, "Badoo_rating.png", 10)
			If $searchResult[0] <> -1 Then
				MouseMove($searchResult[0],$searchResult[1],0)
				MouseClickDrag ( "left", $searchResult[0],$searchResult[1]+50, $searchResult[0]+100,$searchResult[1]+100 )
				Send("{CTRLDOWN}c{CTRLUP}")
				$rating=Number(StringReplace(ClipGet(),",","."));
				
				if $rating>6.2 Then
					;MsgBox($MB_SYSTEMMODAL, "", "good girl" & $rating)
					PressLike()
				Else 
					;MsgBox($MB_SYSTEMMODAL, "", "bad   girl" & $rating)
					PressDislike();
				Endif
			Else
				PressLike()
			EndIf 
		Endif
		
		
	
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
		
		$searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, "Badoo_close_white.png", 10)
		If $searchResult[0] <> -1 Then
			ConsoleWrite("Using " & ": " & $searchResult[0] & ", "& $searchResult[1] & @CRLF)
			MouseMove($searchResult[0],$searchResult[1],0)
			MouseClick("left")
			Sleep(1000)
		EndIf 
		
		
		Sleep(Random(5000,30000))
	Endif
WEnd

	