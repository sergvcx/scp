"%AES%"\aescrypt -e *.ini
if %ERRORLEVEL% neq 0 exit /b
del *.ini