@echo off
REM ##################################################################################
REM ##
REM ##		PROGRAMMED BY LOUISE
REM ##		DATE: 07/01/2025
REM ##
REM ##		How it works:
REM ##		
REM ##		-> The script displays a menu with options to reset Chrome, reset IE, 
REM ##			or exit.
REM ##		-> The user enters their choice.
REM ##		-> The script uses if statements to check the user's input and goto 
REM ##			statements to jump to the appropriate section of code.
REM ##		-> Each reset section performs the respective reset procedure 
REM ##			(either Chrome or IE).
REM ##		-> After completing a reset, the script returns to the main menu, 
REM ##			allowing the user to choose another option or exit.
REM ##		-> If the user chooses to exit, the script terminates.
REM ##
REM ##
REM ##
REM ##
REM ###################################################################################


@echo off
setlocal

echo """"""""""""""""""""""""""""""""""""""""
echo "     ___                              "
echo "    / _ )_______ _    _____ ___ ____  "
echo "   / _  / __/ _ \ |/|/ (_-</ -_) __/  "
echo "  /____/_/  \___/__,__/___/\__/_/     "
echo "    / _ \___ ___ ___ / /_             "
echo "   / , _/ -_|_-</ -_) __/             "
echo "  /_/|_|\__/___/\__/\__/              "
echo "  /_/|_|\__/___/\__/\__/              "
echo "     by ICT Department                "
echo """"""""""""""""""""""""""""""""""""""""


:main_menu
echo.
echo Select a browser to reset:
echo 1. Google Chrome
echo 2. Microsoft Edge
echo 3. Mozilla Firefox
echo 4. Exit
echo.

set "choice="
set /p "choice=Enter your choice (1-4): "

if "%choice%"=="1" goto :chrome_reset
if "%choice%"=="2" goto :edge_reset
if "%choice%"=="3" goto :firefox_reset
if "%choice%"=="4" goto :end

echo Invalid choice. Please try again.
goto :main_menu

:chrome_reset
echo.
echo Closing Chrome...
taskkill /f /im chrome.exe /T >nul 2>&1

echo Trying to reset Chrome with flags first...
start "" "chrome.exe" --disable-extensions --restore-last-session --disable-sync --first-run
timeout /t 5 /nobreak >nul

echo If the Chrome problem persists, you may need to delete user data.
set /p "deleteChromeData=Do you want to DELETE ALL Chrome data? (y/n): "

if /i "%deleteChromeData%" == "y" (
    set "chrome_user_data=%LOCALAPPDATA%\Google\Chrome\User Data"
    echo Deleting Chrome user data...
    rmdir /s /q "%chrome_user_data%"
    echo Starting Chrome with a fresh profile...
    start "" "chrome.exe"
) else (
    echo No changes made to Chrome user data.
)
goto :main_menu


:edge_reset
echo.
echo Closing Edge...
taskkill /f /im msedge.exe /T >nul 2>&1

echo Resetting Microsoft Edge settings...

set "edge_user_data=%LOCALAPPDATA%\Microsoft\Edge\User Data"

if exist "%edge_user_data%" (
    echo Backing up Edge user data (renaming it)...
    for /d %%a in ("%edge_user_data%\*.*") do (
        set "old_profile=%%a"
        set "new_profile=%%a.bak"
        if not exist "%%a.bak" (
            ren "%%a" "%%a.bak"
            echo Profile "%%a" backed up to "%%a.bak"
        ) else (
            echo Backup already exists for "%%a". Skipping backup.
        )
    )
    echo Starting Edge with a new profile...
    start "" "msedge.exe"
) else (
    echo Edge user data not found.
)

goto :main_menu

:firefox_reset
echo.
echo Closing Firefox...
taskkill /f /im firefox.exe /T >nul 2>&1

echo Resetting Firefox profile...
set "firefox_profile=%APPDATA%\Mozilla\Firefox\Profiles"

if exist "%firefox_profile%" (
    echo Backing up Firefox profile (renaming it)...
    for /d %%a in ("%firefox_profile%\*.*") do (
        set "old_profile=%%a"
        set "new_profile=%%a.bak"
        if not exist "%%a.bak" (
            ren "%%a" "%%a.bak"
            echo Profile "%%a" backed up to "%%a.bak"
        ) else (
            echo Backup already exists for "%%a". Skipping backup.
        )
    )
    echo Starting Firefox with a new profile...
    start "" "firefox.exe"
) else (
    echo Firefox profile not found.
)
goto :main_menu

:end
echo Exiting...
endlocal