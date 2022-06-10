Steps to use:
Download PSTools from Microsoft Sysinternals - https://download.sysinternals.com/files/PSTools.zip
Extract the ZIP.
Place the psexec/64 file into C:\Windows\System32
Create 2 shortcuts: 
Command Prompt target:         PsExec/64 -i -s cmd.exe && exit
Windows Powershell target:     PsExec/64 -i -s powershell
Make sure the shortcuts require administrator permissions in the compatibility tab of the file properties.
Place the command prompt shortcut as well as cmdsys.vbs in C:\Windows\System32
Place the powershell shortcut as well as powershellsys.vbs in C:\Windows\System32\WindowsPowerShell\v1.0
Create a shortcut to each vbs script, cmdsys.vbs and powershellsys.vbs, and place them in either the system start menu programs folder or your user start menu programs folder
System: C:\ProgramData\Microsoft\Windows\Start Menu\Programs
User:   %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs
Command prompt shortcut would usually go in the "Windows System" folder, and powershell shortcut in the "Windows Powershell" folder.
Put the icons on the start menu shortcuts if you like. It requires a restart for them to apply correctly. Place them in System32 if you will use them.
Have fun!

NOTE: Running as SYSTEM is not the highest possible privileges one can get. It's running as TrustedInstaller that is the highest privileges. To run programs as TI, use ExecTI: https://winaero.com/execti/
