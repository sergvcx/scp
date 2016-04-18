#include <IE.au3>
#include <MsgBoxConstants.au3>
#include <String.au3>
#include <Array.au3>

$i = 0
;Local $oIE = _IE_Example("form")
local $oIE=_IECreate("rzd.ru")

Sleep(1000)

HotKeySet("{ESC}", "Terminate")
Func Terminate()
    Exit
EndFunc

Func FromToWhen($from,$to,$date)
	Local $oInput = _IEGetObjById($oIE, "name0")
	if @error Then
		MsgBox(0, "Error in _IEGetObjById","name0",1);
		return 0
	Else
		;MsgBox(0, "Found in _IEGetObjById",$oInput.placeholder);
		Local $hIE = _IEPropertyGet($oIE, "hwnd")
		Sleep(100)
		_IEAction($oInput, "focus")
		Sleep(100)
		; Select existing content so it will be overwritten.
		_IEAction($oInput, "selectall")
		Sleep(100)
		ControlSend($hIE, "", "[CLASS:Internet Explorer_Server; INSTANCE:1]", $from)
	EndIf
	
	Local $oInput = _IEGetObjById($oIE, "date0")
	if @error Then
		MsgBox(0, "Error in _IEGetObjById","date0",1);
		return 0
	Else
		;MsgBox(0, "Found in _IEGetObjById",$oInput.placeholder);
		Local $hIE = _IEPropertyGet($oIE, "hwnd")
		Sleep(100)
		_IEAction($oInput, "focus")
		Sleep(100)
		; Select existing content so it will be overwritten.
		_IEAction($oInput, "selectall")
		Sleep(100)
		ControlSend($hIE, "", "[CLASS:Internet Explorer_Server; INSTANCE:1]", $date)
	EndIf
	
	Local $oInput = _IEGetObjById($oIE, "name1")
	if @error Then
		MsgBox(0, "Error in _IEGetObjById","name1",1);
		return 0
	Else
		;MsgBox(0, "Found in _IEGetObjById",$oInput.placeholder);
		Local $hIE = _IEPropertyGet($oIE, "hwnd")
		Sleep(100)
		_IEAction($oInput, "focus")
		Sleep(100)
		; Select existing content so it will be overwritten.
		_IEAction($oInput, "selectall")
		Sleep(100)
		ControlSend($hIE, "", "[CLASS:Internet Explorer_Server; INSTANCE:1]", $to)
	EndIf
	

	
	Local $oInput = _IEGetObjById($oIE, "Submit")
	if @error Then
		MsgBox(0, "Error in _IEGetObjById","Submit",1);
		return 0
	Else
		;MsgBox(0, "Found in _IEGetObjById",$oInput.placeholder);
		Sleep(100)
		_IEAction($oInput, 'click')
		Sleep(300);
	EndIf
EndFunc
	
	
Func WaitForPage()
	Sleep(1000)
	For $i = 10 To 1 Step -1
		
		;_IELoadWait($oIE)
		Local $sHTML = _IEDocReadHTML($oIE)
		;_StringBetween($sHTML,'Сообщить об ошибке','')
		;if @error Then ContinueLoop
			
		;
		; Показано 0 из 0 вариантов по прямому маршруту
		;Не выбран поезд.
		_StringBetween($sHTML,'Невозможно установить соединение с АСУ «Экспресс-3». Пожалуйста, попробуйте выполнить запрос позже','')
		if @error=0 Then return 2
		
		_StringBetween($sHTML,'Показано','вариантов по прямому маршруту')
		if @error=0 Then return 0
		
		; $founds = _StringBetween($sHTML,'<div id="Part0">','Требуется ввести антиспам-код')
		;$founds = _StringBetween($sHTML,'<div id="Part0">'  & @CRLF  & '<div>Требуется ввести антиспам-код</div>','')
		;</div>
	
		;if @error=0 Then 
		;<div id="Part0">
		;<div>Требуется ввести антиспам-код</div>
		;</div>
		;MsgBox(0,"Capcha",UBound($founds))
		;if _ArrayMaxIndex($founds)=1 Then	return 1
		;Endif
		Sleep(1000)
	Next
	
	$founds = _StringBetween($sHTML,'<div id="Part0">'  & @CRLF  & '<div>Требуется ввести антиспам-код</div>','')
	if @error=0 Then 
		MsgBox(0,"Capcha",1)
		return 1
	EndIf
	
	$founds = _StringBetween($sHTML,'<div id="Part0"><div>Требуется ввести антиспам-код</div>','')
	if @error=0 Then 
		MsgBox(0,"Capcha",2)
		return 1
	EndIf
		;<div id="Part0">
		;<div>Требуется ввести антиспам-код</div>
		;</div>
	
	
	return -1
EndFunc

Func CheckTrain($train,$controlWord)
	

		
	Local $oTags = _IETagNameGetCollection($oIE, "table")
	if @error Then
		MsgBox(0,"Error _IETagNameGetCollection","table")
		return
	EndIf
	For $oTag In $oTags
		If $oTag.className = "trlist" Then
			Local $ooTags = _IETagNameGetCollection($oTag, "tr")
			if @error Then
				MsgBox(0,"Error _IETagNameGetCollection","tr" )
				return 0
			EndIf
			For $ooTag In $ooTags
				If $ooTag.className = "trlist__trlist-row trslot " Then 
					Local $oooTags = _IETagNameGetCollection($ooTag, "span")
					For $oooTag In $oooTags
						if $oooTag.className="trlist-transf__header-trtype trlist-transf__header-trtype-0" Then
							;MsgBox(0, "Train" , $oooTag.title)
							Local $trainIDs =_StringBetween($oooTag.title,'Поезд дальнего следования № ','')
							if @error Then ExitLoop
							if $trainIDs[0]= $train Then
								Local $sHTML = _IEPropertyGet($ooTag,"innertext")
								;MsgBox(0,"info",$sHTML)
								if @error Then ExitLoop
								_StringBetween($sHTML,$controlWord,'')
								if @error==0 then return 1
								return 0;
							EndIf
						EndIf
					Next
				EndIf
			Next
		EndIf
	Next
EndFunc
			

							
$From = "МОСКВА"
$To   = "КАЗАНЬ ПАСС"
$Date = "22.04.2016"
FromToWhen($From, $To, $Date);

While $i <= 600

	$pageStatus =WaitForPage() 
	if $pageStatus=1 Then 
		MsgBox(0,"Error", "Ёпанная капча!");
		_IEQuit($oIE)
		Sleep(1000*60*15)
		$oIE=_IECreate("rzd.ru")
		FromToWhen($From, $To, $Date);
		ContinueLoop
	EndIf
	
	if $pageStatus=-1 Then 
		MsgBox(0,"Error", "Таймаут!",10);
		_IEQuit($oIE)
		Sleep(1000)
		$oIE=_IECreate("rzd.ru")
		FromToWhen($From, $To, $Date);
		ContinueLoop
	EndIf
	
	;MsgBox(0,"Ready","Go!",2)
	if CheckTrain("112М","Плац") Then 
		MsgBox(0, "ура" , "Есть плацкарт",2);
	Else 
		MsgBox(0, "Fuck" , "Нету плаца",2);
	Endif

	if CheckTrain("112М","Купе") Then MsgBox(0, "ура" , "Есть Купе",1);
	
	MsgBox(0,"Refresf in","300 sec", 300);
	_IEAction($oIE, "refresh")
	
	$i=$i+1
WEnd