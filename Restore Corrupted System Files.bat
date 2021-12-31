@echo off

    net session >nul 2>&1
    if %errorLevel% == 0 (
	dism /online /cleanup-image /restorehealth
	sfc /scannow
        set /p answer=Cleanup complete press any key to restart (make sure you save your work first)
	PAUSE
	shutdown /r /t 0
	exit
    ) else (
        echo Administrator permissions required to run this script
    )

    pause >nul
