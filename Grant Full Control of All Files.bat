::Run this with terminal-SYS, use Command Prompt with SYSTEM permissions.
::Add more files or directories if needed
::NOTE - This will take a while to run, so you'll probably want to run it overnight. Run it with as little programs running as possible to prevent conflicts.
takeown /f "C:\Program Files" /a /r /d Y
takeown /f "C:\Program Files (x86)" /a /r /d Y
takeown /f "C:\ProgramData" /a /r /d Y
takeown /f "C:\Users" /a /r /d Y
takeown /f "C:\Windows" /a /r /d Y
icacls C:\ /grant Administrators:F /T /C
PAUSE
