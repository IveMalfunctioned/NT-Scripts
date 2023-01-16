# NT-Scripts
A collection of utility scripts I've created or edited for Microsoft Windows

These scripts were made specifically for Windows 10 but it'll probably work with little compatibility issues on Windows 7 and newer.


Decrapify: A script I edited that fixes Microsoft's BS that they put in Windows, such as tracking & telemetry, bloatware, various settings, and other little tweaks here and there.  
Credit: https://www.youtube.com/watch?v=PdKMiFKGQuc  
Changes: Added functionality to uninstall Edge Chromium & Cortana, disable Windows Defender, set network type to private, disable first sign-in animation, show seconds on clock, and fixed an issue where running the script would break Windows search (ctfmon).  
Make sure you customize this script before running it! Never blindly run a script you download off of the internet.

Autofirewall: A script I made to automatically add a list of exe files or all exe files in a list of directories recursively to the firewall in order to deny them internet for better privacy.

Restore corrupted system files: A simple automated script I made to run dism restorehealth and sfc scannow back to back.

terminal-SYSTEM: Scripts to run command prompt and powershell as SYSTEM (higher privileges than Administrator) using psexec. See the readme file inside.
NOTE: Running as SYSTEM is not the highest possible privileges one can get. It's running as TrustedInstaller that is the highest privileges. To run programs as TI, use ExecTI: https://winaero.com/execti/

Grant Full Control of All Files: A script to grant Administrators full control of all files on C:\ (well almost all, but you can add more files/directories if needed). May not work for every single file, so run this with terminal-SYS, use Command Prompt with SYSTEM permissions. Note that this script will take a while to run, so you'll probably want to run it overnight. Run it with as little programs running as possible to prevent conflicts.

Shutdown: A convenient little script to shut down your PC in a specified integer of seconds
