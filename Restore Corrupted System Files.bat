@echo off

    net session >nul 2>&1
    if %errorLevel% == 0 (
	dism /online /cleanup-image /restorehealth
	sfc /scannow
        set /p answer=Cleanup complete, restart? (make sure you save your work first) (y/n)
	if "%answer%"=="y" (GOTO restart)
	if "%answer%"=="n" (exit /b)
	:restart
		shutdown /r /t 0
	:norestart
	exit
    ) else (
        echo Administrator permissions required to run this script
    )

    pause >nul
