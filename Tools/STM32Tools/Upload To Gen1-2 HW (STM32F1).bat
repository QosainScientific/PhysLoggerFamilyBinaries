@echo off
:: Check if a file was dragged and dropped onto the batch file
IF "%~1"=="" (
    echo No file provided. Please drag and drop the .bin file onto this batch file.
    exit /b 1
)

:: Set variables
set uploader_path=%~dp0F1\maple_upload.bat
set port=COM29
set upload_speed=2
set usb_vid_pid=1EAF:0003
set arduino_path="C:\Program Files (x86)\Arduino"
set bin_file=%~1

:: Show feedback of the directories and files being used
echo --------------------------------------
echo Using uploader: %uploader_path%
echo Uploading file: %bin_file%
echo Using COM Port: %port%
echo USB VID:PID: %usb_vid_pid%
echo Arduino Path: %arduino_path%
echo --------------------------------------
echo.

:: Call the uploader script with the required parameters
"%uploader_path%" %port% %upload_speed% %usb_vid_pid% "%bin_file%" %arduino_path%

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
