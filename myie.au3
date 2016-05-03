Func sizeOf($array)
	Local $size=0
	for $item in $array
		$size = $size+1
	Next
	return $size
EndFunc

Func GetTagCollectionByClass($tag,$className,$timeout=0)
	
	$tagString = "<" &$tag & " class='" &$className & "'>"
	;MSG("GetTagCollectionByClass",$tagString )
	Local $tagsFiltered[0]
	Local $ready= 0
	For $i = $timeout To 0 Step -1
		Sleep(1000)
		$tags=_IETagNameGetCollection($oIE, $tag)
		if @error Then 
			MSG("Error " & @error & "in _IETagNameGetCollection","With looking for " & $tagString)
			Exit
		Endif
		
		For $tag in $tags
			if $tag.className==$className Then 
				_ArrayAdd($tagsFiltered,$tag)
				;MSG("info","+1")
				$ready =1 
			EndIf
		Next
		if $ready then 
			;MSG("Info [GetTagCollectionByClass]", sizeOf($tagsFiltered) & " " & $tagString & "were found",10)
			return $tagsFiltered
		EndIf
		if $timeout Then Sleep(1000);
	Next
	SetError(-1)
	;If $timeout and @error  Then 
	;	MSG("Error", "No " & $tagString & "Found",10)
	;EndIf	
	return $tagsFiltered
EndFunc


Func GetTagCollectionByClassIn($doc,$tag,$className,$timeout=0)

	$tagString = "<" &$tag & " class='" &$className & "'>"
	;MSG("GetTagCollectionByClassIn",$tagString )
	Local $tagsFiltered[0]
	Local $ready= 0
	For $i = $timeout To -1 Step -1
		$tags=_IETagNameGetCollection($doc, $tag)
		if @error Then 
			MSG("Error " & @error & "in _IETagNameGetCollection","With looking for " & $tagString)
			Exit
		Endif
		
		For $tag in $tags
			if $tag.className==$className Then 
				_ArrayAdd($tagsFiltered,$tag)
				;MSG("info","+1")
				$ready =1 
			EndIf
		Next
		if $ready then 
			;MSG("Info [GetTagCollectionByClassIn]", sizeOf($tagsFiltered) & " " & $tagString & "were found",10)
			return $tagsFiltered
		EndIf
		Sleep(1000);
	Next
	If $timeout and sizeOf($tagsFiltered)==0 Then 
		MSG("Error", "No " & $tagString & "Found",10)
		SetError(-1)
	EndIf
	return $tagsFiltered
EndFunc

Func GetTagCollectionByTypeIn($doc,$tag,$type,$timeout=0)
	$tagString = "<" &$tag & " class='" &$className & "'>"
	Local $tagsFiltered[0]
	Local $ready= 0
	For $i = $timeout To -1 Step -1
		$tags=_IETagNameGetCollection($doc, $tag)
		if @error Then 
			MSG("Error " & @error & "in _IETagNameGetCollection","With looking for " &$tagString)
			Exit
		Endif
		
		For $tag in $tags
			if $tag.type==$className Then _ArrayAdd($tagsFiltered,$tag)
			$ready =1 
		Next
		if $ready then return $tagsFiltered
		Sleep(1000);
	Next
	If $timeout and sizeOf($tagsFiltered)==0 Then MSG("Error", "No " & $tagString & "Found",10)
	return $tagsFiltered
EndFunc


Func TagHasText($tag,$text)
	Local $sHTML = _IEPropertyGet($tag,"innertext")
	Local $between=_StringBetween($sHTML,$text,'')
	Local $count=0
	while @error=0
		$count = $count+1
		$between=_StringBetween($between[0],$text,'')
	WEnd 
	return $count;
EndFunc

Func GetTagText($tag)
	Local $sHTML = _IEPropertyGet($tag,"innertext")
	;MSG("Innertext",$sHTML)
	Local $txts=_StringBetween($sHTML,$text,'')
	;MSG("",$txts)
	;_ArrayDisplay($txts)
	if @error then return 1;
	;return sizeOf($txts)
EndFunc

				
				
Func GetTagByClassIn($doc,$tag,$className,$timeout=1)
	Local $oTags=GetTagCollectionByClassIn($doc,$tag,$className,$timeout)
	if sizeOf($oTags)==1 Then
		return $oTags[0]
	EndIf
	
	$tagString = "<" &$tag & " class='" &$className & "'>"
	MSG("Error in GetTagByClassIn", sizeOf($oTags) & " tags " & $tagString & " were found")
	SetError(-1)
EndFunc 

Func GetTagByClass($tag,$className,$timeout=1)
	Local $oTags=GetTagCollectionByClass($tag,$className,$timeout)
	if sizeOf($oTags)==1 Then
		return $oTags[0]
	EndIf
	
	$tagString = "<" &$tag & " class='" &$className & "'>"
	;MSG("Error in GetTagByClass", sizeOf($oTags) & " tags " & $tagString & " were found")
	SetError(-1)
EndFunc 


Func ClickTag($tag)
	_IEAction($tag, 'click')
	if @error Then 
		MSG("Error " & @error & "in _IEAction","with click ")
		return
	EndIf
	return 0
EndFunc


Func ClickTagByClass($doc,$tag,$className,$timeout=1)
	Local $tag = GetTagByClass($doc,$tag,$className,$timeout)
	if @error==0 Then 
		_IEAction($tag, 'click')
		if @error Then 
			MSG("Error " & @error & "in _IEAction","with click on " & $tagString)
			return @error
		EndIf
		return 0
	EndIf
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