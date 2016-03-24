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
		;MouseMove(0,0,0)
		Sleep(500)
	EndIf 
EndFunc

Func PressDislike()
    $searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, "Badoo_dislike.png" , 10)
	If $searchResult[0] <> -1 Then
		MouseMove($searchResult[0],$searchResult[1],0)
		Sleep(500)
		MouseClick("left")
		;MouseMove(0,0,0)
		Sleep(500)
	EndIf 
EndFunc





$i = 0

While $i <= 100
	WinActivate ("Badoo")
	If WinActive("Badoo") Then
	
		
		$searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, "Badoo_profile.png", 100)
		If $searchResult[0] <> -1 Then
			Sleep(2000)
			MouseMove($searchResult[0],$searchResult[1],0)
			MouseClick("left")
			Sleep(1000)
			
			$searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, "Badoo_rating.bmp", 100)
			If $searchResult[0] <> -1 Then
				MouseMove($searchResult[0],$searchResult[1],0)
				MouseClickDrag ( "left", $searchResult[0],$searchResult[1]+50, $searchResult[0]+100,$searchResult[1]+100 )
				Send("{CTRLDOWN}c{CTRLUP}")
				$rating=Number(StringReplace(ClipGet(),",","."));
				
				if $rating>6.2 Then
					MsgBox($MB_SYSTEMMODAL, "", "good girl with " & $rating,1)
					PressLike()
				Else 
					MsgBox($MB_SYSTEMMODAL, "", "bad   girl with " & $rating, 1)
					PressDislike();
				Endif
			Else
				MsgBox($MB_SYSTEMMODAL, "", "unrated girl" , 1)
				PressLike()
			EndIf 
		Else 
			MsgBox($MB_SYSTEMMODAL, "", "Profile not found , count=" & $i, 1)
		Endif
		
		
	
		$searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, "Badoo_close.png", 100)
		If $searchResult[0] <> -1 Then
			MouseMove($searchResult[0],$searchResult[1],0)
			MouseClick("left")
			Sleep(1000)
		EndIf 
	
		$searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, "Badoo_connect.png", 100)
		If $searchResult[0] <> -1 Then
			MouseMove($searchResult[0],$searchResult[1],0)
			MouseClick("left")
			Sleep(1000)
		EndIf 
		
		$searchResult = findImage(0, 0, @DesktopWidth, @DesktopHeight, "Badoo_close_white.png", 100)
		If $searchResult[0] <> -1 Then
			MouseMove($searchResult[0],$searchResult[1],0)
			MouseClick("left")
			Sleep(1000)
		EndIf 
		
		$i= $i+1
		Sleep(Random(2000,2000))
	Endif
WEnd

	;		ConsoleWrite("Using " & ": " & $searchResult[0] & ", "& $searchResult[1] & @CRLF)
	