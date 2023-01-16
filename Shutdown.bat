@echo off
:one
set /p Input=Enter integer delay before shutting down (seconds): 
set /p confirm=Shut down in %Input% seconds (y/n) 
if "%confirm%" == "y" goto two
if "%confirm%" == "n" goto one
:two
echo.
echo Shutting down in %Input% seconds...
echo.
echo Type 'shutdown /a' to cancel.
echo.
shutdown /s /t %Input%
cmd.exe
PAUSE
exit