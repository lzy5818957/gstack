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

:: Find Git Bash
set "GITBASH="
if exist "%ProgramFiles%\Git\bin\bash.exe" set "GITBASH=%ProgramFiles%\Git\bin\bash.exe"
if "%GITBASH%"=="" if exist "%ProgramFiles(x86)%\Git\bin\bash.exe" set "GITBASH=%ProgramFiles(x86)%\Git\bin\bash.exe"
if "%GITBASH%"=="" for /f "delims=" %%i in ('where bash 2^>nul') do set "GITBASH=%%i"

if "%GITBASH%"=="" (
    echo.
    echo WARNING: Git Bash not found. Skipping setup.
    echo Install Git for Windows, then re-run install.bat, or run ./setup from Git Bash manually.
    echo.
    goto :done
)

:: Check if bun is installed, auto-install if missing
"%GITBASH%" -c "command -v bun" >nul 2>&1
if errorlevel 1 (
    echo bun not found. Installing bun...
    powershell -Command "irm bun.sh/install.ps1 | iex" 2>nul
    if errorlevel 1 (
        echo.
        echo WARNING: Failed to auto-install bun.
        echo Install bun manually: https://bun.sh/docs/installation
        echo Then re-run install.bat, or run ./setup from Git Bash manually.
        echo.
        goto :done
    )
    echo bun installed successfully.
)

echo Running setup via Git Bash...
"%GITBASH%" -c "./setup"

:done

echo.
echo gstack installed globally. Available in all Claude Code sessions.
echo Skills: /pm, /status, /report, /design-html, /learn, and all original gstack skills.
echo.
echo To uninstall, run uninstall.bat
pause
