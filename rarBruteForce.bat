@echo off

echo.
set /p rar_file="Enter full rar file name: "
set /p destination_dir="Enter path to the destination directory: "
set /p wordlist="Enter full path to the wordlist file: "

set "seven_zip_path=C:\Program Files\7-Zip\7z.exe"

:: Check for 7z
if not exist "%seven_zip_path%" (
    echo 7-Zip executable not found at %seven_zip_path%.
    exit /b 1
)

:: Check for .rar 
if not exist "%destination_dir%\%rar_file%" (
    echo The file %rar_file% does not exist in %destination_dir%.
    exit /b 1
)

:: Check for wordlist 
if not exist "%wordlist%" (
    echo The wordlist file %wordlist% does not exist.
    exit /b 1
)

:: Brute da .rar 
for /f "delims=" %%p in (%wordlist%) do (
    "%seven_zip_path%" x "%destination_dir%\%rar_file%" -o"%destination_dir%" -p"%%p" -y >nul 2>&1
    if errorlevel 1 (
        echo Trying password: %%p
    ) else (
        echo Correct password found: %%p
        echo Extraction completed successfully.
        goto end_script
    )
)

echo No correct password was found in the wordlist.
:end_script
pause
