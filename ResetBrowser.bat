@echo off
REM ##################################################################################
REM ##
REM ##		PROGRAMMED BY LOUISE
REM ##		DATE: 07/01/2025
REM ##
REM ##		How it works:
REM ##		
REM ##		-> The script displays a menu with options to Restarting set Chrome, Restarting set IE, 
REM ##			or exit.
REM ##		-> The user enters their choice.
REM ##		-> The script uses if statements to check the user's input and goto 
REM ##			statements to jump to the appropriate section of code.
REM ##		-> Each Restarting set section performs the respective Restarting set procedure 
REM ##			(either Chrome or IE).
REM ##		-> After completing a Restarting set, the script returns to the main menu, 
REM ##			allowing the user to choose another option or exit.
REM ##		-> If the user chooses to exit, the script terminates.
REM ##
REM ##
REM ##
REM ##
REM ###################################################################################


@echo off
REM setlocal

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

echo Starting Browser Reset...
echo.

call :reset_chrome
call :reset_edge
call :reset_firefox

echo.
echo Browser reset process complete.
pause
endlocal

:reset_chrome
where chrome.exe >nul 2>&1
if errorlevel 1 (
    echo Chrome is not installed. Skipping Chrome reset.
    goto :eof  REM Changed to goto :eof
)

echo.
echo Resetting Chrome...
taskkill /f /im chrome.exe /T >nul 2>&1
echo Trying to reset Chrome with flags first...
start "" "chrome.exe" --disable-extensions --restore-last-session --disable-sync --first-run
timeout /t 5 /nobreak >nul
echo If the Chrome problem persists, you may need to manually delete user data at %LOCALAPPDATA%\Google\Chrome\User Data
goto :eof REM Changed to goto :eof

:reset_edge
where msedge.exe >nul 2>&1
if errorlevel 1 (
    echo Edge is not installed. Skipping Edge reset.
    goto :eof REM Changed to goto :eof
)

echo.
echo Resetting Microsoft Edge...
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
goto :eof REM Changed to goto :eof

:reset_firefox
where firefox.exe >nul 2>&1
if errorlevel 1 (
    echo Firefox is not installed. Skipping Firefox reset.
    goto :eof REM Changed to goto :eof
)

echo.
echo Resetting Firefox...
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
goto :eof REM Changed to goto :eof