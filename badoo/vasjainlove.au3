#include <IE.au3>
#include <MsgBoxConstants.au3>
#include <String.au3>
#include <Array.au3>
#include "../msg.au3"
$i = 0
;Local $oIE = _IE_Example("form")
local $oIE=_IECreate("https://loveplanet.ru/a-search/item-1/d-1/foto-1/p-0/pol-1/spol-2/geo-3159,4312,4400/bage-20/tage-28/gmap-1/country-3159/region-4312/city-4400/")

Sleep(2000)

;HotKeySet("{ESC}", "Terminate")
Func Terminate()
    Exit
EndFunc



Func PressLike()
	Local $oTags = _IETagNameGetCollection($oIE, "a")
	if @error Then
		MSG("Error","in PressLike 1")
		return
	EndIf
	For $oTag In $oTags
		If $oTag.className = "gbut_grd_green gnl_but36 w190" Then
				_IEAction($oTag, 'click')
			;Local $ooTags = _IETagNameGetCollection($oTag, "span")
			;if @error Then
			;	MSG("Error","in PressLike 2")
			;	return
			;EndIf
			;For $ooTag In $ooTags
			;	If $ooTag.className = "b-link js-profile-header-vote" Then
			;		MSG( "I Like", "I like " & $i,1)
			;		_IEAction($ooTag, 'click')
			;	EndIf
			;Next
		EndIf
	Next
EndFunc


Func PressDisLike()
	Local $oTags = _IETagNameGetCollection($oIE, "div")
	if @error Then
		MSG("Error","in PressDisLike 1")
		return
	EndIf
	For $oTag In $oTags
		If $oTag.className = "btn-game btn-game--not js-profile-header-vote-no" Then
			Local $ooTags = _IETagNameGetCollection($oTag, "span")
			
			if @error Then
				MSG("Error","in PressDisLike 2" )
				return
			EndIf
			For $ooTag In $ooTags
				If $ooTag.className = "b-link js-profile-header-vote" Then
					MSG( "I don't Like", "I don't like " & $i,1)
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
		MSG("Error","in GetScore")
		return
	EndIf
	
	For $ooTag In $ooTags
		If $ooTag.className = "b-link js-profile-header-toggle js-profile-header-toggle-button" Then
			;MSG( "Click Profile", "")
			Sleep(1000)
			_IEAction($ooTag, 'click')
			Sleep(1000)
			Local $sHTML = _IEDocReadHTML($oIE)
			Local $scores = _StringBetween($sHTML,'data-score="','">')
			if @error Then
				return 0
			else
				For $score In $scores
					;MSG( "Score", $score,1)	
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
		MSG("Error","in CloseInvite")
		return
	EndIf
	For $oTag In $oTags
		If $oTag.className = "icon-svg icon-svg--white js-ovl-close" Then
			MSG( "Invite ?", "Fuck Off",1)
			_IEAction($oTag, 'click')
			Sleep(Random(2000,50000))
			return 
		EndIf
	Next
EndFunc

Func CloseConnect()
	Local $oTags = _IETagNameGetCollection($oIE, "a")
	if @Error Then
		MSG("Error","in CloseConnect")
		return
	EndIf
	For $oTag In $oTags
		If $oTag.className = "dlg_pu_close_bs10" Then
			MSG( "Connect ?", "Ok",1)
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
;		MSG("Error","in CloseInvite")
;		return
;	EndIf
;	For $oTag In $oTags
;		If $oTag.className = "photo-gallery__photo js-mm-photo-holder" Then
;			Local $ooImgs = _IEImgGetCollection($oTag)
;			For $ooImg In $ooImgs
;				;If $ooTag.className = "js-mm-photo" Then
;				$n = @extended
;				MSG( "Click  ?", "on image" & $n)
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
		MSG("Error","in CloseInvite")
		return
	EndIf
	For $oTag In $oTags
		If $oTag.className = "photo-gallery__link photo-gallery__link--next js-gallery-next" Then
			MSG( "Click  ?", "on image",1)
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
	PressLike()
	Sleep(Random(2000,5000))
	$i=$i+1
WEnd