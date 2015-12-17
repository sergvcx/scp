;#include <MsgBoxConstants.au3>
; 0x0419	Russian (ru)	0x19	LANG_RUSSIAN	Russia (RU)	0x01	SUBLANG_RUSSIAN_RUSSIA
; 0x0409	United States (US)	0x01	SUBLANG_ENGLISH_US
Func _WinAPI_GetKeyboardLayout($hWnd)

    Local $Ret = DllCall('user32.dll', 'long', 'GetWindowThreadProcessId', 'hwnd', $hWnd, 'ptr', 0)

    If (@error) Or ($Ret[0] = 0) Then
        Return SetError(1, 0, 0)
    EndIf
    
    $Ret = DllCall('user32.dll', 'long', 'GetKeyboardLayout', 'long', $Ret[0])
    
	;MsgBox($MB_SYSTEMMODAL, "", "name is: " & $Ret[0])
	
    If (@error) Or ($Ret[0] = 0) Then
        Return SetError(1, 0, 0)
    EndIf
    
    Return '0000' & Hex($Ret[0], 4)
    
EndFunc   ;==>_WinAPI_GetKeyboardLayout


Func _WinAPI_SetKeyboardLayout($sLayout, $hWnd)

    If Not WinExists($hWnd) Then
        Return SetError(1, 0, 0)
    EndIf
    
    Local $Ret = DllCall('user32.dll', 'long', 'LoadKeyboardLayout', 'str', StringFormat('%08s', StringStripWS($sLayout, 8)), 'int', 0)

   ; If (@error) Or ($Ret[0] = 0) Then[url="http://msdn.microsoft.com/en-us/library/dd318693(VS.85).aspx"]http://msdn.microsoft.com/en-us/library/dd318693(VS.85).aspx[/url]
   ;     Return SetError(1, 0, 0)
   ; EndIf
    
    DllCall('user32.dll', 'ptr', 'SendMessage', 'hwnd', $hWnd, 'int', 0x0050, 'int', 1, 'int', $Ret[0])
    
    Return SetError(0, 0, 1)
    
EndFunc   ;==>_WinAPI_SetKeyboardLayout

$RU = 0419
$EN = 0409
;$hWnd=WinGetHandle ("[CLASS:TTOTAL_CMD]")
;$hWnd=WinGetHandle ("Langu")
;$lang=_WinAPI_GetKeyboardLayout($hwnd);
;MsgBox($MB_SYSTEMMODAL, "", "name is: " & $lang)