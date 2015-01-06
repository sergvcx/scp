"%AES%"\aescrypt -d *.aes
if %ERRORLEVEL% neq 0 exit /b
rem del *.aes