@echo off
git submodule update --init --recursive
setlocal enabledelayedexpansion

REM Initialize variables to store path and branch
set "current_path="
set "current_branch="

REM Read the file line by line
for /f "tokens=*" %%A in (.gitmodules) do (
    set "line=%%A"
    
    REM Check if the line contains a path
    echo !line! | findstr /r /c:"^[ ]*path[ ]*=" >nul
    if not errorlevel 1 (
        for /f "tokens=2 delims==" %%B in ("!line!") do set "current_path=%%B"
    )
    
    REM Check if the line contains a branch
    echo !line! | findstr /r /c:"^[ ]*branch[ ]*=" >nul
    if not errorlevel 1 (
        for /f "tokens=2 delims==" %%B in ("!line!") do set "current_branch=%%B"
        
        REM Print the path and branch once both are found
        echo Path: !current_path!
        cd !current_path!
        echo Branch: !current_branch!
        git checkout !current_branch!
        git pull
        echo.
        cd ..\..
    )
)

endlocal
