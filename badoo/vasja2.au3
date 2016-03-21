#include <IE.au3>
#include <MsgBoxConstants.au3>
#include <String.au3>
#include <Array.au3>


;Local $oIE = _IE_Example("form")
local $oIE=_IECreate("http://badoo.com")

Sleep(2000)

HotKeySet("{ESC}", "Terminate")
Func Terminate()
    Exit
EndFunc

Func PressLike()
	Local $oTags = _IETagNameGetCollection($oIE, "div")
	For $oTag In $oTags
		If $oTag.className = "btn-game btn-game--hot js-profile-header-vote-yes" Then
			Local $ooTags = _IETagNameGetCollection($oTag, "span")
			For $ooTag In $ooTags
				If $ooTag.className = "b-link js-profile-header-vote" Then
					MsgBox(0, "I Like", "I like",1)
					_IEAction($ooTag, 'click')
				EndIf
			Next
		EndIf
	Next
EndFunc


Func PressDisLike()
	Local $oTags = _IETagNameGetCollection($oIE, "div")
	For $oTag In $oTags
		If $oTag.className = "btn-game btn-game--not js-profile-header-vote-no" Then
			Local $ooTags = _IETagNameGetCollection($oTag, "span")
			For $ooTag In $ooTags
				If $ooTag.className = "b-link js-profile-header-vote" Then
					MsgBox(0, "I don't Like", "I don't like",1)
					_IEAction($ooTag, 'click')
				EndIf
			Next
		EndIf
	Next
EndFunc

Func GetScore()
	Local $ooTags = _IETagNameGetCollection($oIE, "span")
	For $ooTag In $ooTags
		If $ooTag.className = "b-link js-profile-header-toggle js-profile-header-toggle-button" Then
			;MsgBox(0, "Click Profile", "")
			Sleep(1000)
			_IEAction($ooTag, 'click')
			Sleep(1000)
			Local $sHTML = _IEDocReadHTML($oIE)
			Local $scores = _StringBetween($sHTML,'data-score="','">')
			if @error Then
				return 0
			else
				For $score In $scores
					;MsgBox(0, "Score", $score,1)	
					return number($score)
				Next
			EndIf
		EndIf
	Next
	return 0
EndFunc
 
 
 
Func CloseInvite()
	Local $oTags = _IETagNameGetCollection($oIE, "i")
	For $oTag In $oTags
		If $oTag.className = "icon-svg icon-svg--white js-ovl-close" Then
			MsgBox(0, "close invite", "I don't like")
			_IEAction($ooTag, 'click')
			return 
		EndIf
	Next
EndFunc


$i = 0
While $i <= 600
	;MsgBox(0, "counter", $i,1)
	CloseInvite()
	Local $score = GetScore()
	if $score >6.2 Then
		PressLike()
	ElseIf	$score==0 Then
		PressLike()
	Else
		PressDisLike()
	EndIf
	Sleep(1000)
	$i=$i+1
WEnd