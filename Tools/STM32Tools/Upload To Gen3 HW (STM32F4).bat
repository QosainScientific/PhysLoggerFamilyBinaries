@echo off
:: Check if a file was dragged and dropped onto the batch file
IF "%~1"=="" (
    echo No file provided. Please drag and drop the .bin file onto this batch file.
    exit /b 1
)

:: Set variables
set uploader_path=%~dp0F4\busybox.exe
set uploader_script=%~dp0F4\stm32CubeProg.sh
set bin_file=%~1

:: Show feedback of the directories and files being used
echo --------------------------------------
echo Using uploader: %uploader_path%
echo Uploading file: %bin_file%
echo Uploader script: %uploader_script%
echo --------------------------------------
echo.

:: Call the uploader script with the required parameters
"%uploader_path%" sh "%uploader_script%" 2 "%bin_file%" -g

:: Check if the upload was successful
IF %ERRORLEVEL% NEQ 0 (
    echo Upload failed.
    pause
    exit /b 1
) ELSE (
    echo Upload successful!
)

:: Keep the console open after the upload completes
pause
