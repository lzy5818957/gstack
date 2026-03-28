@echo off
setlocal

set TARGET=%USERPROFILE%\.claude\skills\gstack

echo Installing gstack to %TARGET% ...

if exist "%TARGET%" (
    echo Existing installation found. Removing...
    rmdir /s /q "%TARGET%"
)

xcopy /e /i /q "%~dp0" "%TARGET%"

cd /d "%TARGET%"
git checkout feat/pm-layer 2>nul

if exist "%TARGET%\setup" (
    echo Running setup...
    cd /d "%TARGET%" && bash ./setup
)

echo.
echo gstack installed globally. Available in all Claude Code sessions.
echo Skills: /pm, /status, /report, and all original gstack skills.
echo.
echo To uninstall, run uninstall.bat
pause
