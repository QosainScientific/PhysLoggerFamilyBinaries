@echo off
REM Drag and Drop Batch file for AVRDUDE flashing with verbose output (USBasp)
REM Assumes avrdude.exe is located in ..\Tools\AVRDUDESS relative to this script.

set AVRDUDE_PATH=..\Tools\AVRDUDESS\avrdude.exe
set PROGRAMMER=usbasp
set MCU=atmega328p
set HEXFILE=PhysDisp.hex

REM Execute avrdude with the fixed file (PhysDisp.hex)
%AVRDUDE_PATH% -v -p %MCU% -B 32 -c %PROGRAMMER% -U flash:w:"%HEXFILE%":i

if errorlevel 1 (
    echo.
    echo An error occurred while flashing. Check connections and parameters.
) else (
    echo.
    echo Successfully flashed the device!
)

pause
