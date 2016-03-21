#include <IE.au3>
#include <MsgBoxConstants.au3>
#include <String.au3>
#include <Array.au3>

$i = 0
;Local $oIE = _IE_Example("form")
local $oIE=_IECreate("http://badoo.com")

Sleep(2000)

HotKeySet("{ESC}", "Terminate")
Func Terminate()
    Exit
EndFunc

Func PressLike()
	Local $oTags = _IETagNameGetCollection($oIE, "div")
	if @error Then
		MsgBox(0,"Error","in PressLike 1")
		return
	EndIf
	For $oTag In $oTags
		If $oTag.className = "btn-game btn-game--hot js-profile-header-vote-yes" Then
			Local $ooTags = _IETagNameGetCollection($oTag, "span")
			if @error Then
				MsgBox(0,"Error","in PressLike 2")
				return
			EndIf
			For $ooTag In $ooTags
				If $ooTag.className = "b-link js-profile-header-vote" Then
					MsgBox(0, "I Like", "I like " & $i,1)
					_IEAction($ooTag, 'click')
				EndIf
			Next
		EndIf
	Next
EndFunc


Func PressDisLike()
	Local $oTags = _IETagNameGetCollection($oIE, "div")
	if @error Then
		MsgBox(0,"Error","in PressDisLike 1")
		return
	EndIf
	For $oTag In $oTags
		If $oTag.className = "btn-game btn-game--not js-profile-header-vote-no" Then
			Local $ooTags = _IETagNameGetCollection($oTag, "span")
			
			if @error Then
				MsgBox(0,"Error","in PressDisLike 2" )
				return
			EndIf
			For $ooTag In $ooTags
				If $ooTag.className = "b-link js-profile-header-vote" Then
					MsgBox(0, "I don't Like", "I don't like " & $i,1)
					_IEAction($ooTag, 'click')
					Sleep(1000)
					_IEAction($ooTag, 'click')
				EndIf
			Next
		EndIf
	Next
EndFunc

Func GetScore()
	Local $ooTags = _IETagNameGetCollection($oIE, "span")
	if @error Then
		MsgBox(0,"Error","in GetScore")
		return
	EndIf
	
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
	if @Error Then
		MsgBox(0,"Error","in CloseInvite")
		return
	EndIf
	For $oTag In $oTags
		If $oTag.className = "icon-svg icon-svg--white js-ovl-close" Then
			MsgBox(0, "Invite ?", "Fuck Off")
			_IEAction($oTag, 'click')
			Sleep(Random(2000,50000))
			return 
		EndIf
	Next
	
EndFunc

; 
;Func ClickImage()
;	Local $oTags = _IETagNameGetCollection($oIE, "div")
;	if @Error Then
;		MsgBox(0,"Error","in CloseInvite")
;		return
;	EndIf
;	For $oTag In $oTags
;		If $oTag.className = "photo-gallery__photo js-mm-photo-holder" Then
;			Local $ooImgs = _IEImgGetCollection($oTag)
;			For $ooImg In $ooImgs
;				;If $ooTag.className = "js-mm-photo" Then
;				$n = @extended
;				MsgBox(0, "Click  ?", "on image" & $n)
;				Sleep(1000)
;				_IEAction($ooImg, 'click')
;				Sleep(1000)
;				_IEAction($ooImg, 'click')
;				Sleep(Random(1000,2000))
;				return 
;				;EndIf
;			Next
;		EndIf
;	Next
;	
;EndFunc

Func ClickImage()
	Local $oTags = _IETagNameGetCollection($oIE, "span")
	if @Error Then
		MsgBox(0,"Error","in CloseInvite")
		return
	EndIf
	For $oTag In $oTags
		If $oTag.className = "photo-gallery__link photo-gallery__link--next js-gallery-next" Then
			MsgBox(0, "Click  ?", "on image",1)
			Sleep(1000)
			_IEAction($oTag, 'click')
			Sleep(1000)
		EndIf
	Next
	
EndFunc

;<span class="photo-gallery__link photo-gallery__link--next js-gallery-next">
;<i class="icon-svg icon-svg--white photo-gallery__arrow photo-gallery__arrow--right"><svg xmlns="http://www.w3.org/2000/svg" class="rtl-reflect icon-svg_"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#gallery-right-arrow" /></svg></i>
;</span>


;<div class="photo-gallery__photo js-mm-photo-holder">
;<img class="js-mm-photo" alt="" src="//pcache-eu1.badoocdn.com/p34/hidden?euri=5QzAExwpNvTDiHwrbP-RPfK-LQkIpTOJclsK3EGSMGmzAA7qqJPSDmoe8VkZCpdRKalCFz1-yvnRlDWQ8kW0bntlhcAhwvq.qkFlfkANKuYKXsXatF858N6vqAWPHMx5kHSY4iqjWML.9qV7E2qTH9r.N51NdDsX&amp;id=19156&amp;size=__size__&amp;wm_size=103x103&amp;wm_offs=18x18">
;</div>


While $i <= 600
	MsgBox(0, "counter", $i,1)
	
	CloseInvite()
	;_IEImgClick($oIE,"//pcache-eu1.")
	ClickImage()
	Sleep(1000)
	Local $score = GetScore()
	PressLike()
	if $score >6.2 Then
		PressLike()
	ElseIf	$score==0 Then
		PressLike()
	Else
		PressDisLike()
	EndIf
	;PressLike()
	Sleep(Random(2000,5000))
	$i=$i+1
WEnd