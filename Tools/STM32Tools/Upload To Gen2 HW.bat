@echo off
REM Check if a file was dropped on the batch file
if "%~1"=="" (
    echo No file was dropped on the batch file. Exiting.
    pause
    exit /b
)

REM COM port, integer arguments, and other fixed arguments
set COMPort=COM23
set Arg1=2
set Arg2=1EAF:0003
set DroppedFile=%~1
set ArduinoDir="C:\Program Files (x86)\Arduino"

REM Display the file chosen by dropping
echo File chosen: %DroppedFile%

REM Set the path to the F1 directory where the jar and other files are located
set F1Dir=%~dp0F1

REM Display the address of the F1 directory
echo F1 directory: %F1Dir%

REM Set the PATH to include the Arduino directory for Java
set PATH=%ArduinoDir%\java\bin;%PATH%

REM Execute the java jar file with the appropriate arguments from the F1 directory
echo Executing: java -jar %F1Dir%\maple_loader.jar %COMPort% %Arg1% %Arg2% %DroppedFile%
java -jar %F1Dir%\maple_loader.jar %COMPort% %Arg1% %Arg2% %DroppedFile%

REM Wait for the COM port to be ready
for /l %%x in (1, 1, 40) do (
  ping -w 50 -n 1 192.0.2.1 > nul
  mode %COMPort% > nul
  if ERRORLEVEL 0 goto comPortFound
)

echo Timeout waiting for %COMPort% serial
goto end

:comPortFound
echo COM port %COMPort% found.

:end
echo.
echo Process complete. Press any key to exit.
pause
