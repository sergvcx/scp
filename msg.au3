$showMsgBox = 1
Func MSG($title,$message,$timeout=0)
	if $showMsgBox Then
		Local $timeoutMsg ="" 
		if $timeout Then $timeoutMsg= @CRLF  & "[Waiting for " & $timeout & " seconds ...]"
		$status=MsgBox($MB_YESNOCANCEL,$title,$message &  @CRLF & @CRLF & "Show message again?" & $timeoutMsg   ,$timeout)
		if $status==$IDYES Then return 
		if $status==$IDNO Then $showMsgBox=0
		if $status==$IDCANCEL  Then Exit
	EndIf
EndFunc



Func MSG_MODAL($title,$message,$timeout=0)
	if $showMsgBox Then
		Local $timeoutMsg ="" 
		if $timeout Then $timeoutMsg= @CRLF  & "[Waiting for " & $timeout & " seconds ...]"
		$status=MsgBox($MB_YESNOCANCEL+$MB_SYSTEMMODAL	,$title,$message &  @CRLF & @CRLF & "Show message again?" & $timeoutMsg   ,$timeout)
		if $status==$IDYES Then return 
		if $status==$IDNO Then $showMsgBox=0
		if $status==$IDCANCEL  Then Exit
	EndIf
EndFunc