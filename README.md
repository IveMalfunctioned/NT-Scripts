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

Shutdown: A convenient little script to shut down your PC in a specified integer of seconds. Must be ran as administrator or else it will not function properly.

Download-AppxPackage: A powershell script with a function to download appx-packages and their dependencies from Microsoft Store links, as well as a function to install all packages in a specified directory. Originally by AJ Wilson.

Fully Remove Microsoft Edge: A script I created to fully manually de-integrate Microsoft Edge from Windows 10, after Microsoft decided they didn't want to let users remove it claiming it is "integral" to Windows. It includes a script to also fully remove Internet Explorer (which Edge depends on) as well as the option to re-install the Microsoft store (the script may break it) (using the aforementioned Download-AppxPackage script originally by AJ Wilson) **This script requires WIMTweak.exe to be in the same directory as the script.** Includes elements from [Rentry Uninstall Edge](https://rentry.org/uninstalledge)https://rentry.org/uninstalledge and [Winaero Uninstall Edge](https://winaero.com/how-to-uninstall-and-remove-edge-browser-in-windows-10/)https://winaero.com/how-to-uninstall-and-remove-edge-browser-in-windows-10/
