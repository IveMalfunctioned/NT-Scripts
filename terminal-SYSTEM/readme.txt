Steps to use:
Download PSTools from Microsoft Sysinternals - https://download.sysinternals.com/files/PSTools.zip
Extract the ZIP.
Place the psexec/psexec64 (depending on system architecture) file into C:\Windows\System32
Create 2 shortcuts (Remove the '64' if you chose the x86 file): 
Command Prompt target (named "cmdsyslnk"):                    PsExec64 -i -s /accepteula cmd.exe && exit
Windows Powershell target (named "powershellsyslnk"):         PsExec64 -i -s /accepteula powershell
Make sure the shortcuts require administrator permissions in the compatibility tab of the file properties.
Place the command prompt shortcut as well as cmdsys.vbs in C:\Windows\System32
Place the powershell shortcut as well as pssys.vbs in C:\Windows\System32\WindowsPowerShell\v1.0
Create a shortcut to cmdsys.vbs named "Command Prompt (SYTEM)" and one to pssys.vbs named "Windows Powershell (SYSTEM)", and place them in either the system start menu programs folder or your user start menu programs folder, depending on if you want the shortcut visible to all users (The command still works for all users, just requires administrator privileges)
System: C:\ProgramData\Microsoft\Windows\Start Menu\Programs
User:   %USERPROFILE%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs
The command prompt shortcut would fit best in the "Windows System" folder, and the powershell shortcut would fit best in the "Windows Powershell" folder.
Put the icons on the start menu shortcuts if you like. It requires a restart for them to apply correctly. System32 is a good permanent spot for them where they will be untouched.

With that, you're finished. Enjoy!
The command for Command Prompt (SYSTEM) is "cmdsys".
The command for Windows Powershell (SYSTEM) is "pssys".

NOTE: Running as SYSTEM is not the highest possible privileges one can get. It's running as TrustedInstaller that is the highest privileges. To run programs as TI, use ExecTI: https://winaero.com/execti/
