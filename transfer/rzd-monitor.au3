#include <IE.au3>
#include <MsgBoxConstants.au3>
#include <String.au3>
#include <Array.au3>
#include "../msg.au3"

$ini = "rzd.ini"
$section = "path"
$From    = IniRead ( $ini, $section, "from", "" )
$To      = IniRead ( $ini, $section, "to", "" )
$Date    = IniRead ( $ini, $section, "date", "" )
$Train   = IniRead ( $ini, $section, "train", "" )
$Class   = IniRead ( $ini, $section, "class", "" )
$ccc     = IniRead ( $ini, $section, "ccc", "" )

$section = "login"
$Login   = IniRead ( $ini, $section, "login", "" )
$Password= IniRead ( $ini, $section, "password", "" )


$ini = "plastic.ini"
$section = "hkb"
$card  = IniRead ( $ini, $section, "card", "" )
$name  = IniRead ( $ini, $section, "name", "" )
$surname=IniRead ( $ini, $section, "surname", "" )
$month = IniRead ( $ini, $section, "month", "" )
$year  = IniRead ( $ini, $section, "year", "" )
$ccc   = IniRead ( $ini, $section, "ccc", "" )
$card  = StringStripWS($card, $STR_STRIPALL )

$i = 0
;Local $oIE = _IE_Example("form")


Sleep(1000)

HotKeySet("{ESC}", "Terminate")
Func Terminate()
    Exit
EndFunc


Func InputTextByID($id,$text)
	Local $oInput = _IEGetObjById($oIE, $id)
	if @error Then
		MSG( "Error in _IEGetObjById",$id,10);
		return @error
	EndIF
		;MSG( "Found in _IEGetObjById",$oInput.placeholder);
	Local $hIE = _IEPropertyGet($oIE, "hwnd")
	if @error Then
		MSG( "Error in _IEPropertyGet","",10);
		return @error
	EndIF
	
	Sleep(100)
	_IEAction($oInput, "focus")
	Sleep(100)
	; Select existing content so it will be overwritten.
	_IEAction($oInput, "selectall")
	Sleep(100)
	ControlSend($hIE, "", "[CLASS:Internet Explorer_Server; INSTANCE:1]", $text)
	return 0
EndFunc

Func InputTextByName($name,$text)
	Local $oInput = _IEGetObjByName($oIE, $name)
	if @error Then
		MSG( "Error in _IEGetObjByName",$name,10);
		return @error
	EndIF
		;MSG( "Found in _IEGetObjById",$oInput.placeholder);
	Local $hIE = _IEPropertyGet($oIE, "hwnd")
	if @error Then
		MSG( "Error in _IEPropertyGet","",10);
		return @error
	EndIF
	
	Sleep(100)
	_IEAction($oInput, "focus")
	Sleep(100)
	; Select existing content so it will be overwritten.
	;_IEAction($oInput, "selectall")
	Sleep(100)
	ControlSend($hIE, "", "[CLASS:Internet Explorer_Server; INSTANCE:1]", $text)
	return 0
EndFunc


Func SelectComboByName($name,$line)
	Local $oInput = _IEGetObjByName($oIE, $name)
	if @error Then
		MSG( "Error in _IEGetObjByName",$name,10);
		return @error
	EndIF
		;MSG( "Found in _IEGetObjById",$oInput.placeholder);
	Local $hIE = _IEPropertyGet($oIE, "hwnd")
	if @error Then
		MSG( "Error in _IEPropertyGet","",10);
		return @error
	EndIF
	
	Sleep(100)
	Sleep(2000)
	_IEAction($oInput, "focus")
	
	Sleep(100)
	;Send("{DOWN}")
	;Send("{DOWN}")
	Sleep(2000)
	_IEAction($oInput, "click")
	Sleep(2000)
	ControlSend($hIE, "Панель навигации", "[CLASS:Internet Explorer_Server; INSTANCE:1]", "Ж")
	;ControlCommand($hIE, "Панель навигации", "[CLASS:Internet Explorer_Server; INSTANCE:1]", "ShowDropDown")
	Sleep(2000)
	;ControlCommand($hIE, "Панель навигации", "[CLASS:Internet Explorer_Server; INSTANCE:1]", "SelectString","Мужской")
	return 0
EndFunc

Func DownComboByName($name,$from,$to)
	Local $oInput = _IEGetObjByName($oIE, $name)
	if @error Then
		MSG( "Error in _IEGetObjByName",$name,10);
		return @error
	EndIF
		;MSG( "Found in _IEGetObjById",$oInput.placeholder);
	
	
	Sleep(100)
	_IEAction($oInput, "focus")
	Sleep(1000)
	For $m = $from To $to Step 1
		Send("{DOWN}") 
		Sleep(100)
	Next
	return 0
EndFunc



Func InputClickByID($id)
	Local $oInput = _IEGetObjById($oIE, $id)
	if @error Then
		MSG( "Error in _IEGetObjById",$id,10);
		return @error
	EndIF
	_IEAction($oInput, 'click')
	return 0
EndFunc
	
Func InputClickByName($name)
	Local $oInput = _IEGetObjByName($oIE, $name)
	if @error Then
		MSG( "Error in _IEGetObjById",$id,10);
		return @error
	EndIF
	_IEAction($oInput, 'click')
	return 0
EndFunc

Func InputClickByClass($className)
	Local $oInputs = _IETagNameGetCollection($oIE, "input")
	if @error Then 
		MSG("Error in _IETagNameGetCollection","button")
		;Sleep(1000)
	EndIf
	For $oInput In $oInputs
		if $oInput.className=$className Then
			_IEAction($oInput, 'click')
			return @error
		EndIf
	Next
	return -1
EndFunc


	
Func FromToWhen($from,$to,$date)
	InputTextByID("date0",$date)
	InputTextByID("name0",$from)
	InputTextByID("name1",$to)
	InputClickByID("Submit");
EndFunc

Func ClickButtonByClass($className)
	For $i = 10 To 1 Step -1
		Local $oButtons = _IETagNameGetCollection($oIE, "button")
		if @error Then 
			MSG("Error in _IETagNameGetCollection","button")
			;Sleep(1000)
			ContinueLoop
		EndIf
		For $oButton In $oButtons
			if $oButton.className=$className Then
				_IEAction($oButton, 'click')
				return @error
			EndIf
		Next
		Sleep(100)
	Next
	MSG("Error","No button found " & $className)
	return -1
EndFunc

Func ClickButtonByType($type)
	For $i = 10 To 1 Step -1
		Local $oButtons = _IETagNameGetCollection($oIE, "button")
		if @error Then 
			MSG("Error in _IETagNameGetCollection","button")
			;Sleep(1000)
			ContinueLoop
		EndIf
		For $oButton In $oButtons
			if $oButton.type=$type Then
				_IEAction($oButton, 'click')
				return @error
			EndIf
		Next
		Sleep(100)
	Next
	MSG("Error","No button found " & $type)
	return -1
EndFunc


Func Authorization()
	;if WaitForPage("Логин",10)==0 Then 
	InputTextByID("j_username", $Login)
	Sleep(1000)
	InputTextByID("j_password", $Password)
	Sleep(1000)
	ClickButtonByClass("btn btn-color-grey btn-icon btn-icon-grey btn-icon-right fri")
	return 0
	;EndIf
	;return -1
EndFunc
	
Func WaitForPage($keyWord,$timeout)
	For $i = $timeout To 1 Step -1
		Local $sHTML = _IEDocReadHTML($oIE)
		_StringBetween($sHTML,$keyWord,'')
		if @error=0 Then 
			
			return 0
		EndIf
		MSG("Sleep","waiting for <" & $keyWord  & "> " & $i,2)
	Next
	MSG("Timeout","Timeout off " & $keyWord ,1)
	return -1
EndFunc
	
Func CheckCapcha()
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
		;MSG("Capcha",UBound($founds))
		;if _ArrayMaxIndex($founds)=1 Then	return 1
		;Endif
		Sleep(1000)
	Next
	
	$founds = _StringBetween($sHTML,'<div id="Part0">'  & @CRLF  & '<div>Требуется ввести антиспам-код</div>','')
	if @error=0 Then 
		MSG("Capcha",1)
		return 1
	EndIf
	
	$founds = _StringBetween($sHTML,'<div id="Part0"><div>Требуется ввести антиспам-код</div>','')
	if @error=0 Then 
		MSG("Capcha",2)
		return 1
	EndIf
		;<div id="Part0">
		;<div>Требуется ввести антиспам-код</div>
		;</div>
	
	
	return -1
EndFunc




Func CheckRadioWagon($keyWord)
	Local $oTRs = _IETagNameGetCollection($oIE, "tr")
	if @error Then
		MSG("Error _IETagNameGetCollection","tr")
		return -1
	EndIf
	For $oTR In $oTRs
		If $oTR.className ="j-car-item trlist__trlist-row trlist__trlist-row-last-sub-item" Then 
			Local $sHTML = _IEPropertyGet($oTR,"innertext")
			if @error Then 
				MSG("Error in _IEPropertyGet","oTR");
				return -1
			EndIf
			_StringBetween($sHTML,$keyWord,'')
			if @error==0 Then
				Local $oRadios = _IETagNameGetCollection($oTR, "input")
				if @error Then 
					MSG("Error in _IETagNameGetCollection","oTR");
					return -1
				EndIf
				For $oRadio In $oRadios
					If $oRadio.type=="radio" Then
						_IEAction($oRadio, 'click')
						return 0
					EndIf
				Next
			EndIf
		EndIf
	Next
	return -1
EndFunc

Func CheckRadioTrain($trainTag)
	Local $oInputs = _IETagNameGetCollection($trainTag, "input")
	if @error Then
		MSG("Error _IETagNameGetCollection","input")
		return
	EndIf
	For $oInput In $oInputs
		If $oInput.className = "j-train-radio" Then 
			_IEAction($oInput, 'click')
			return 0
		EndIf
	Next
	return -1
EndFunc

Func CheckTickets($train,$keyWord)
	Local $oTags = _IETagNameGetCollection($oIE, "table")
	if @error Then
		MSG("Error _IETagNameGetCollection","table")
		return -2
	EndIf
	For $oTag In $oTags
		If $oTag.className = "trlist" Then
			Local $ooTags = _IETagNameGetCollection($oTag, "tr")
			if @error Then
				MSG("Error _IETagNameGetCollection","tr" )
				return -3
			EndIf
			For $ooTag In $ooTags
				If $ooTag.className = "trlist__trlist-row trslot " Then 
					Local $oooTags = _IETagNameGetCollection($ooTag, "span")
					For $oooTag In $oooTags
						if $oooTag.className="trlist-transf__header-trtype trlist-transf__header-trtype-0" Then
							;MSG( "Train" , $oooTag.title)
							Local $trainIDs =_StringBetween($oooTag.title,'Поезд дальнего следования № ','')
							if @error Then ExitLoop
							if $trainIDs[0]= $train Then
								Local $sHTML = _IEPropertyGet($ooTag,"innertext")
								;MSG("info",$sHTML)
								if @error Then ExitLoop
								_StringBetween($sHTML,$keyWord,'')
								if @error==0 then 
									;MSG("Sleep","Radio train",3);
									if WaitForPage("Не выбран поезд",10) Then MSG("Fuck","")
									Sleep(1000)
									if CheckRadioTrain($ooTag) Then MSG("Fuck of train select","")
									Sleep(1000)
									;MSG("Sleep","Radio wagon",3);
									ClickButtonByClass("btn btn-color-red btn-icon btn-icon-red btn-icon-right disabledImit")
									;MSG("Sleep","Radio wagon",3);
									;_IELoadWait($oIE)
									Sleep(1000)
									if WaitForPage("<span>МЖ",10) Then MSG("Fuck","2")
									
									Sleep(2000)
									if CheckRadioWagon($Class) Then MSG("Fuck of wagon select","")
									Sleep(1000)
									;MSG("Sleep","Radio wagon",3);
									ClickButtonByClass("btn btn-color-red btn-icon btn-icon-red btn-icon-right");
									;MSG("Sleep","Athorization",3);
									
									
									For $i = 10 To 1 Step -1 
										
										if WaitForPage("Логин",2)==0 Then 
											Authorization() 
										EndIf
										
										
										
										if WaitForPage("Список пассажиров",2)==0 Then 
											EnterPassanger()
											Sleep(1000)
											ClickButtonByClass("btn btn-color-red btn-icon btn-icon-right btn-icon-red")
											
											if WaitForPage("Сумма к оплате",10) Then MSG("Shit","Сумма к оплате")
											Sleep(1000)
											InputClickByClass("fle marR15")
											Sleep(1000)
											ClickButtonByClass("btn btn-color-red btn-icon btn-icon-red btn-icon-right")
											
											if WaitForPage("Оплата банковской картой",10) Then MSG("Shit","Оплата банковской картой")
											
											InputTextByName("pan",$card)
											Sleep(1000)
											InputTextByName("cvv2",$ccc)
											Sleep(1000)
											InputTextByName("fio",$name & " " & $surname)
											WinActivate ("TW")
											Sleep(1000)
											DownComboByName("expMon",1,$month)
											Sleep(1000)
											DownComboByName("ExpYear",16,$year)
											Sleep(1000)
											ClickButtonByType("submit")
											
											return 0
											ExitLoop
										Endif
										
										
											
										MSG("Sleep", "Waiting for page ..." & $i , 1)
									Next
									
									
									return 1
								EndIf
								return 1;
							EndIf
						EndIf
					Next
				EndIf
			Next
		EndIf
	Next
	return -1
EndFunc
			
Func EnterPassanger()
	if WaitForPage("Список пассажиров",10)==0 Then 
		;Sleep(1000)
		;$oGender= _IEFormElementGetObjByName($oIE,"gender")
		;if @error then MSG("no gender" , @error);
		;_IEFormElementCheckBoxSelect($oGender,"Мужской")
		
		InputTextByName("birthdate","31.08.1977")
		InputTextByName("lastName","Мушкаев")
		InputTextByName("firstName","Сергей")
		InputTextByName("docNumber","4509512486")
		
		;SelectComboByName("gender","1")
		InputTextByName("gender","М")
		InputClickByName("insCheck")
		
		return 0
	EndIf
	return -1
EndFunc


local $oIE=_IECreate("rzd.ru")
_IELoadWait($oIE)
WaitForPage("Пассажирам",10) 

FromToWhen($From, $To, $Date);

Func PageError()
	Local $sHTML = _IEDocReadHTML($oIE)
	_StringBetween($sHTML,"Невозможно установить соединение с АСУ",'')
	if @error==0 Then 
		MSG("Problem in page","Невозможно установить соединение с АСУ, wait:",10)
		return -1001	; 
	EndIf
	_StringBetween($sHTML,"В настоящий момент сервер не может обработать ваш запрос",'')
	if @error==0 Then 
		MSG("Problem in page","В настоящий момент сервер не может обработать ваш запрос, wait:",10)
		return -1002; 
	EndIf
	return 0
EndFunc


While $i <= 600

	if WaitForPage("вариантов по прямому маршруту",15) Then 
		MSG("Problem", "Нет вариантов по прямому маршруту..." ,10 );
		_IEQuit($oIE)
		Sleep(1000*60*5)
		$oIE=_IECreate("rzd.ru")
		FromToWhen($From, $To, $Date);
		ContinueLoop
	EndIf
	
	
	$status = CheckTickets($Train,$Class)
	
										
	;MSG("Shit",$status,10)
	if PageError() Then 
		_IEQuit($oIE)
		Sleep(1000*60*5)
		$oIE=_IECreate("rzd.ru")
		FromToWhen($From, $To, $Date);
		ContinueLoop
	EndIf
				
	if $status ==0 Then
		MSG( "ура" , "Есть " & $Class);
	Else 
		MSG( "Fuck" , "Нету " & $Class ,2);
	Endif
	
	MSG("Refresh","Sleep...", 200);
	_IEAction($oIE, "refresh")
	
	$i=$i+1
WEnd

;$pageStatus =
;	if $pageStatus=1 Then 
;		MSG("Error", "Ёпанная капча!");
;		_IEQuit($oIE)
;		Sleep(1000*60*15)
;		$oIE=_IECreate("rzd.ru")
;		FromToWhen($From, $To, $Date);
;		ContinueLoop
;	EndIf
;	
;	if $pageStatus=-1 Then 
;		MSG("Error", "Таймаут!",10);
;		_IEQuit($oIE)
;		Sleep(1000)
;		$oIE=_IECreate("rzd.ru")
;		FromToWhen($From, $To, $Date);
;		ContinueLoop
;	EndIf
;	
;	;MSG("Ready","Go!",2)
;	
;
;	;if CheckTickets("112М","Купе") Then MSG( "ура" , "Есть Купе",1);