#include <IE.au3>
#include <MsgBoxConstants.au3>
#include <String.au3>
#include <Array.au3>
Global $oIE=_IECreate("http://badoo.com")
#include "../msg.au3"
#include "../myie.au3"
$i = 0
;Local $oIE = _IE_Example("form")


$showMsgBox=1

Sleep(2000)

;HotKeySet("{ESC}", "Terminate")
Func Terminate()
    Exit
EndFunc


Func PressYesNo($answer)
	Sleep(1000)
	Local $oTags = GetTagCollectionByClass("span","b-link js-profile-header-vote",5)
	if @error Then 
		MSG("PressYesNo","error")
		return -1
	endif
	if $answer="yes" Then
		_IEAction($oTags[0], 'click')
	else 
		_IEAction($oTags[1], 'click')
	EndIf
EndFunc


Func GetScore()
	Sleep(1000)
	Local $sHTML = _IEDocReadHTML($oIE)
	Local $scores = _StringBetween($sHTML,'data-score="','">')
	if @error Then return 0
	return number($scores[0])
EndFunc
 



;Func ClickImage()
;	Local $oTags = _IETagNameGetCollection($oIE, "span")
;	if @Error Then
;		MSG("Error","in ClickImage")
;		return
;	EndIf
;	For $oTag In $oTags
;		If $oTag.className = "photo-gallery__link photo-gallery__link--next js-gallery-next" Then
;			;MSG( "Click  ?", "on image",2)
;			Sleep(1000)
;			_IEAction($oTag, 'click')
;			Sleep(1000)
;		EndIf
;	Next
;	
;EndFunc




Func Close600()
	Local $oTags = _IETagNameGetCollection($oIE, "i")
	if @Error Then
		MSG("Error","in CloseInvite")
		return
	EndIf
	For $oTag In $oTags
		If $oTag.className = "icon-svg icon-svg--white js-ovl-close" Then
		
			Local $sHTML = _IEDocReadHTML($oIE)
			Local $scores = _StringBetween($sHTML,'<h1>У вас закончились голоса','!</h1>')
			
			if @error Then
				return 0
			else
				For $score In $scores
					MSG( "Out of 600", "Sleep 1800 #" & $i,1800)
					_IEAction($oTag, 'click')
					Sleep(Random(2000,50000))
					return 
				Next
			EndIf
		EndIf
	Next
EndFunc

Func IfSpam()

	Local $oTag = GetTagByClass($oIE, "i","icon-svg icon-svg--white js-ovl-close")
	if @error Then return 
	
	Local $sHTML  = _IEDocReadHTML($oIE)
	Local $scores = _StringBetween($sHTML,'<h1>Повысьте свои шансы','!</h1>')
	if @error=0 Then 
		IEAction($oTag, 'click')
		return
	EndIf
EndFunc


Func If600()

	Local $oTag = GetTagByClass($oIE, "i","icon-svg icon-svg--white js-ovl-close")
	if @error Then return 
	
	Local $sHTML  = _IEDocReadHTML($oIE)
	Local $scores = _StringBetween($sHTML,'<h1>У вас закончились голоса','!</h1>')
	if @error=0 Then 
		IEAction($oTag, 'click')
		MSG("Info","Закончились голоса",100)
	EndIf
EndFunc


;<span class="photo-gallery__link photo-gallery__link--next js-gallery-next">
;<i class="icon-svg icon-svg--white photo-gallery__arrow photo-gallery__arrow--right"><svg xmlns="http://www.w3.org/2000/svg" class="rtl-reflect icon-svg_"><use xmlns:xlink="http://www.w3.org/1999/xlink" xlink:href="#gallery-right-arrow" /></svg></i>
;</span>


;<div class="photo-gallery__photo js-mm-photo-holder">
;<img class="js-mm-photo" alt="" src="//pcache-eu1.badoocdn.com/p34/hidden?euri=5QzAExwpNvTDiHwrbP-RPfK-LQkIpTOJclsK3EGSMGmzAA7qqJPSDmoe8VkZCpdRKalCFz1-yvnRlDWQ8kW0bntlhcAhwvq.qkFlfkANKuYKXsXatF858N6vqAWPHMx5kHSY4iqjWML.9qV7E2qTH9r.N51NdDsX&amp;id=19156&amp;size=__size__&amp;wm_size=103x103&amp;wm_offs=18x18">
;</div>


;While $i <= 600
;	MSG( "counter", $i,2)
;	
;	;CloseInvite()
;	Close600()
;	CloseChance()
;	;_IEImgClick($oIE,"//pcache-eu1.")
;	ClickImage()
;	Sleep(1000)
;	Local $score = GetScore()
;	MSG("Score",$score,10);
;	PressLike()
;	if $score >6.2 Then
;		PressLike()
;	ElseIf	$score==0 Then
;		PressLike()
;	Else
;		PressDisLike()
;	EndIf
;	;PressLike()
;	Sleep(Random(2000,5000))
;	$i=$i+1
;WEnd

Func ClickIconProfile()
	Sleep(1000)
	$oIcons=GetTagCollectionByClass("div","btn btn--white btn--ico",5)
	if @error Then return -1
	for $oIcon in $oIcons 
		$oTooltip=GetTagByClassIn($oIcon,"span","tooltip-txt",5)
		if @error Then return -1
		if TagHasText($oTooltip,"Профиль")==1 Then 
			$ooIcon=GetTagByClassIn($oIcon,"span","b-link js-profile-header-toggle-layout",5)
			if @error Then return -1
			_IEAction($ooIcon,'click')	
			return 0
		EndIf
	Next 
	return -1
EndFunc

 	

While 1
	MSG("Sleep","Zzzzz...",150);
	
	IfSpam();
	If600()
	if ClickIconProfile()<0 Then ContinueLoop
	Local $score = 	GetScore();
	MSG("score",$score,1);
	if $score >6.2 Then
		MSG("I say","Yes",1)
		PressYesNo("yes")
	ElseIf	$score==0 Then
		MSG("I say","Yes with no score",1)
		PressYesNo("yes")
	Else
		MSG("I say","No",1)
		PressYesNo("no")
	EndIf

	

	
WEnd