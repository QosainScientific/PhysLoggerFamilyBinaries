@echo off
:: Check if a file was dragged and dropped onto the batch file
IF "%~1"=="" (
    echo No file provided. Please drag and drop the .bin file onto this batch file.
    exit /b 1
)

:: Set variables
set bin_file=%~1

:: Check if the file name contains F1 or F4
echo Checking hardware version from file name...

echo.
:: If F1 is found in the filename, use the STM32F1 upload script
echo File dropped: %bin_file%
echo.

:: Check for F1 in the file name
echo Checking if the file is for Gen1-2 HW (STM32F1)...
echo.
IF NOT "%bin_file%" == "%bin_file:F1=%" (
    goto stm32f1_upload
)

:: Check for F4 in the file name
echo Checking if the file is for Gen3 HW (STM32F4)...
IF NOT "%bin_file%" == "%bin_file:F4=%" (
    goto stm32f4_upload
)

:: Neither F1 nor F4 found, prompt the user to select
:choose_hw
echo No hardware version detected from file name.
echo Please choose the hardware version:
echo 1. Gen1-2 HW (STM32F1)
echo 2. Gen3 HW (STM32F4)
set /p hw_choice=Enter your choice (1 or 2): 
echo.
        
IF "%hw_choice%" == "1" (
    goto stm32f1_upload
) ELSE IF "%hw_choice%" == "2" (
    goto stm32f4_upload
) ELSE (
    echo Invalid choice. Please enter 1 or 2.
    goto choose_hw
)

:: STM32F1 Upload
:stm32f1_upload
echo Uploading to Gen1-2 HW (STM32F1)...
echo.
echo As soon as you continue, plug in PhysLogger in bootloader mode.
echo Plug in the USB as soon as we continue
echo.
pause
call "%~dp0Upload To Gen1-2 HW (STM32F1).bat" "%bin_file%"
goto end

:: STM32F4 Upload
:stm32f4_upload
echo Uploading to Gen3 HW (STM32F4)...
echo.
echo As soon as you continue, plug in PhysLogger in bootloader mode.
echo Hold the Boot button and plug in the USB.
echo.
pause
call "%~dp0Upload To Gen3 HW (STM32F4).bat" "%bin_file%"
goto end

:end
echo Done.
pause
