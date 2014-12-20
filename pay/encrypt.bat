"%AES%"\aescrypt -e *.scp
if %ERRORLEVEL% neq 0 exit /b
del *.scp