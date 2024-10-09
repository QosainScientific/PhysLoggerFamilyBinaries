@echo off
cd /d "%~dp0"


:loop
cls
echo Uploading %~1
busybox.exe sh stm32CubeProg.sh 2 %~1 -g
timeout /t 3 /nobreak
goto loop