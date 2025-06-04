@echo off
:: Check if a file was dragged and dropped onto the batch file
IF "%~1"=="" (
    echo No file provided. Please drag and drop the .bin file onto this batch file.
    exit /b 1
)

:: Set variables
set bin_file=%~1

:: Show the file being uploaded
echo File dropped: %bin_file%
echo.

:: Call the original uploader script located in the \Tools\STM32Tools directory
call "%~dp0..\Tools\STM32Tools\__Drop any PhysLogger Binary on me__.bat" "%bin_file%"

:: Done
echo Done.
pause
