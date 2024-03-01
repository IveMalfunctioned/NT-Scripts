:: Includes bits from https://rentry.org/uninstalledge and https://winaero.com/how-to-uninstall-and-remove-edge-browser-in-windows-10/
:: Created by IveMalfunctioned
:: This script requires WIMTweak.exe, which you can download from archived pages of the above Winaero link.
@echo off
@setlocal DisableDelayedExpansion
if defined PROCESSOR_ARCHITEW6432 start %SystemRoot%\Sysnative\cmd.exe /c "%0 " &exit
reg.exe query "HKU\S-1-5-19" 1>nul 2>nul || (echo Run the script as TrustedInstaller with ExecTI&goto :TheEnd)

set root=%cd%
set "u_path=%LocalAppData%\Microsoft"
set "s_path=%ProgramFiles(x86)%\Microsoft"
if /i %PROCESSOR_ARCHITECTURE%==x86 (if not defined PROCESSOR_ARCHITEW6432 (
  set "s_path=%ProgramFiles%\Microsoft"
  )
)

@cls
echo.
choice /C YN /N /M "Microsoft Edge Chromium will be unintalled. Continue? [y/n]: "
if errorlevel 2 exit

set removeIE=1
choice /C YN /N /M "Remove Internet Explorer also? [y/n]: "
if errorlevel 2 set removeIE=0

echo.
echo Terminating processes...
taskkill /im msedge.exe /f >NUL 2>&1
taskkill /im MicrosoftEdgeUpdate.exe /f >NUL 2>&1
taskkill /im identity_helper.exe /f >NUL 2>&1
sc stop "MicrosoftEdgeElevationService" >NUL 2>&1
sc stop "edgeupdate" >NUL 2>&1
sc stop "edgeupdatem" >NUL 2>&1

PAUSE

echo.
echo Attempting setup uninstall...

reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v NoRemove /f 2>nul
reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v NoRemove /f 2>nul
reg delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v NoRemove /f 2>nul

for /D %%i in ("%u_path%\Edge SxS\Application\*") do if exist "%%i\installer\setup.exe" (
echo Canary...
start "" /w "%%i\installer\setup.exe" --uninstall --msedge-sxs --verbose-logging --force-uninstall --delete-profile
)
for /D %%i in ("%u_path%\Edge Internal\Application\*") do if exist "%%i\installer\setup.exe" (
echo Internal...
start "" /w "%%i\installer\setup.exe" --uninstall --msedge-internal --verbose-logging --force-uninstall --delete-profile
)
for /D %%i in ("%u_path%\Edge Dev\Application\*") do if exist "%%i\installer\setup.exe" (
echo Dev...
start "" /w "%%i\installer\setup.exe" --uninstall --msedge-dev --verbose-logging --force-uninstall --delete-profile
)
for /D %%i in ("%u_path%\Edge Beta\Application\*") do if exist "%%i\installer\setup.exe" (
echo Beta...
start "" /w "%%i\installer\setup.exe" --uninstall --msedge-beta --verbose-logging --force-uninstall --delete-profile
)
for /D %%i in ("%u_path%\Edge\Application\*") do if exist "%%i\installer\setup.exe" (
echo Stable...
start "" /w "%%i\installer\setup.exe" --uninstall --verbose-logging --force-uninstall --delete-profile
)
for /D %%i in ("%u_path%\EdgeWebView\Application\*") do if exist "%%i\installer\setup.exe" (
echo WebView2 Runtime...
start "" /w "%%i\installer\setup.exe" --uninstall --msedgewebview --verbose-logging --force-uninstall --delete-profile
)

for /D %%i in ("%s_path%\EdgeWebView\Application\*") do if exist "%%i\installer\setup.exe" (
echo WebView2 Runtime...
start "" /w "%%i\installer\setup.exe" --uninstall --msedgewebview --system-level --verbose-logging --force-uninstall --delete-profile
)
for /D %%i in ("%s_path%\Edge\Application\*") do if exist "%%i\installer\setup.exe" (
echo Stable...
start "" /w "%%i\installer\setup.exe" --uninstall --system-level --verbose-logging --force-uninstall --delete-profile
)
for /D %%i in ("%s_path%\Edge Beta\Application\*") do if exist "%%i\installer\setup.exe" (
echo Beta...
start "" /w "%%i\installer\setup.exe" --uninstall --msedge-beta --system-level --verbose-logging --force-uninstall --delete-profile
)
for /D %%i in ("%s_path%\Edge Dev\Application\*") do if exist "%%i\installer\setup.exe" (
echo Dev...
start "" /w "%%i\installer\setup.exe" --uninstall --msedge-dev --system-level --verbose-logging --force-uninstall --delete-profile
)
for /D %%i in ("%s_path%\Edge Internal\Application\*") do if exist "%%i\installer\setup.exe" (
echo Internal...
start "" /w "%%i\installer\setup.exe" --uninstall --msedge-internal --system-level --verbose-logging --force-uninstall --delete-profile
)

PAUSE

echo.
echo Removing program entry...
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView" /f 2>nul

PAUSE

echo.
echo Removing scheduled tasks and services...
schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineCore" /f 2>nul
schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineUA" /f 2>nul
sc config "MicrosoftEdgeElevationService" start=disabled >NUL 2>&1
sc config "edgeupdate" start=disabled >NUL 2>&1
sc config "edgeupdatem" start=disabled >NUL 2>&1

PAUSE

echo.
echo Removing edge...
sc delete "MicrosoftEdgeElevationService" >NUL 2>&1
sc delete "edgeupdate" >NUL 2>&1
sc delete "edgeupdatem" >NUL 2>&1
cd /d "C:\Windows\SystemApps\*MicrosoftEdge*" 2>nul && del /f /s /q * 2>nul
cd /d "C:\Program Files\WindowsApps\*MicrosoftEdge*" 2>nul && del /f /s /q * 2>nul
cd /d "C:\Program Files (x86)\Microsoft\Edge" 2>nul && del /f /s /q * 2>nul
cd /d "C:\Program Files (x86)\Microsoft\EdgeCore" 2>nul && del /f /s /q * 2>nul
cd /d "C:\Program Files (x86)\Microsoft\EdgeUpdate" 2>nul && del /f /s /q * 2>nul
cd /d "C:\Program Files (x86)\Microsoft\EdgeWebView" 2>nul && del /f /s /q * 2>nul

PAUSE

echo.
echo Removing registry integrations...
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Edge" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\MSEdgeHTM" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\MSEdgeMHT" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\MSEdgePDF" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\.htm" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\.html" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\.mht" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\.mhtml" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\.pdf" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\.shtml" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\.svg" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\.webp" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\.xht" /f 2>nul
reg delete "HKEY_CLASSES_ROOT\.xhtml" /f 2>nul

reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.htm" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.html" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.mht" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.mhtml" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.pdf" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.svg" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.shtml" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.webp" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.xht" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\.xhtml" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\MSEdgeHTM" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\MSEdgeMHT" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Classes\MSEdgePDF" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Clients\StartMenuInternet\Microsoft Edge" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Internet Explorer\Main\EnterpriseMode" /v MSEdgePath /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\MediaPlayer\ShimInclusionList\msedge.exe" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_microsoft-edge /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Clients\StartMenuInternet\Microsoft Edge" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{56EB18F8-B008-4CBD-B6D2-8C97FE7E9062}\Commands\on-os-upgrade" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\App Paths\msedge.exe" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\EventLog\Application\Edge" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\EventLog\Application\edgeupdate" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001\Services\EventLog\Application\edgeupdatem" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Application\Edge" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Application\edgeupdate" /f 2>nul
reg delete "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\EventLog\Application\edgeupdatem" /f 2>nul

reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm" /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html" /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht" /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml" /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf" /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.shtml" /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg" /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.webp" /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xht" /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xhtml" /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.htm /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.html /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.mht /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.mhtml /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.svg /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.webp /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.http /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.https /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.mailto /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.read /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.pdf /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice" /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\microsoft-edge" /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\microsoft-edge-holographic" /f 2>nul
reg delete "HKEY_CURRENT_USER\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" /v "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" /f 2>nul

reg load "hku\Default" "C:\Users\Default\NTUSER.DAT"
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.htm" /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.html" /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mht" /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.mhtml" /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.pdf" /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.shtml" /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.svg" /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.webp" /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xht" /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\FileExts\.xhtml" /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.htm /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.html /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.mht /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.mhtml /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.svg /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.webp /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.http /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.https /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.mailto /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.read /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\CurrentVersion\ApplicationAssociationToasts" /v MSEdgeHTM_.pdf /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\http\UserChoice" /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\microsoft-edge" /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows\Shell\Associations\UrlAssociations\microsoft-edge-holographic" /f 2>nul
reg delete "HKEY_USERS\Default\SOFTWARE\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Compatibility Assistant\Store" /v "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe" /f 2>nul
reg unload "hku\Default"
echo Removed edge file assocation. You may need to reset your default apps for HTML, PDF, SVG, and WEBP files.

PAUSE

echo.
echo Removing shortcuts...
del /f /q "%AppData%\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge*.lnk" 2>nul
del /f /q "%SystemRoot%\System32\config\systemprofile\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge*.lnk" 2>nul
del /f /q "%HOMEPATH%\Desktop\Microsoft Edge*.lnk" 2>nul
del /f /q "%USERPROFILE%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Microsoft Edge*.lnk" 2>nul
del /f /q "%USERPROFILE%\Desktop\Microsoft Edge*.lnk" 2>nul
del /f /q "%ALLUSERSPROFILE%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge*.lnk" 2>nul
cd /d "%root%"
WIMTweak.exe /o /l
WIMTweak.exe /o /c Microsoft-Windows-Internet-Browser-Package /r
WIMTweak.exe /h /o /l

PAUSE

echo.
echo Preventing edge from re-installing...
reg add "HKLM\SOFTWARE\Microsoft\EdgeUpdate" /v DoNotUpdateToEdgeWithChromium /t REG_DWORD /d 1 /f 1>nul
(
	echo :: Initialize
	echo @echo off
	echo set "u_path=%%LocalAppData%%\Microsoft"
	echo set "s_path=%%ProgramFiles(x86)%%\Microsoft"
	echo if /i %%PROCESSOR_ARCHITECTURE%%==x86 (if not defined PROCESSOR_ARCHITEW6432 ^(
	echo   set "s_path=%%ProgramFiles%%\Microsoft"
	echo   ^)
	echo ^)

	echo :: Terminate processes
	echo taskkill /im msedge.exe /f
	echo taskkill /im MicrosoftEdgeUpdate.exe /f
	echo taskkill /im identity_helper.exe /f
	echo sc stop "MicrosoftEdgeElevationService"
	echo sc stop "edgeupdate"
	echo sc stop "edgeupdatem"

	echo :: Attemp setup uninstall
	echo reg delete "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v NoRemove /f
	echo reg delete "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v NoRemove /f
	echo reg delete "HKLM\SOFTWARE\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /v NoRemove /f

	echo for /D %%%%i in ("%%u_path%%\Edge SxS\Application\*"^) do if exist "%%%%i\installer\setup.exe" ^(
	echo :: Canary...
	echo start "" /w "%%%%i\installer\setup.exe" --uninstall --msedge-sxs --verbose-logging --force-uninstall --delete-profile
	echo ^)
	echo for /D %%%%i in ("%%u_path%%\Edge Internal\Application\*"^) do if exist "%%%%i\installer\setup.exe" ^(
	echo :: Internal...
	echo start "" /w "%%%%i\installer\setup.exe" --uninstall --msedge-internal --verbose-logging --force-uninstall --delete-profile
	echo ^)
	echo for /D %%%%i in ("%%u_path%%\Edge Dev\Application\*"^) do if exist "%%%%i\installer\setup.exe" ^(
	echo :: Dev...
	echo start "" /w "%%%%i\installer\setup.exe" --uninstall --msedge-dev --verbose-logging --force-uninstall --delete-profile
	echo ^)
	echo for /D %%%%i in ("%%u_path%%\Edge Beta\Application\*"^) do if exist "%%%%i\installer\setup.exe" ^(
	echo :: Beta...
	echo start "" /w "%%%%i\installer\setup.exe" --uninstall --msedge-beta --verbose-logging --force-uninstall --delete-profile
	echo ^)
	echo for /D %%%%i in ("%%u_path%%\Edge\Application\*"^) do if exist "%%%%i\installer\setup.exe" ^(
	echo :: Stable...
	echo start "" /w "%%%%i\installer\setup.exe" --uninstall --verbose-logging --force-uninstall --delete-profile
	echo ^)
	echo for /D %%%%i in ("%%u_path%%\EdgeWebView\Application\*"^) do if exist "%%%%i\installer\setup.exe" ^(
	echo :: WebView2 Runtime...
	echo start "" /w "%%%%i\installer\setup.exe" --uninstall --msedgewebview --verbose-logging --force-uninstall --delete-profile
	echo ^)

	echo for /D %%%%i in ("%%s_path%%\EdgeWebView\Application\*"^) do if exist "%%%%i\installer\setup.exe" ^(
	echo :: WebView2 Runtime...
	echo start "" /w "%%%%i\installer\setup.exe" --uninstall --msedgewebview --system-level --verbose-logging --force-uninstall --delete-profile
	echo ^)
	echo for /D %%%%i in ("%%s_path%%\Edge\Application\*"^) do if exist "%%%%i\installer\setup.exe" ^(
	echo :: Stable...
	echo start "" /w "%%%%i\installer\setup.exe" --uninstall --system-level --verbose-logging --force-uninstall --delete-profile
	echo ^)
	echo for /D %%%%i in ("%%s_path%%\Edge Beta\Application\*"^) do if exist "%%%%i\installer\setup.exe" ^(
	echo :: Beta...
	echo start "" /w "%%%%i\installer\setup.exe" --uninstall --msedge-beta --system-level --verbose-logging --force-uninstall --delete-profile
	echo ^)
	echo for /D %%%%i in ("%%s_path%%\Edge Dev\Application\*"^) do if exist "%%%%i\installer\setup.exe" ^(
	echo :: Dev...
	echo start "" /w "%%%%i\installer\setup.exe" --uninstall --msedge-dev --system-level --verbose-logging --force-uninstall --delete-profile
	echo ^)
	echo for /D %%%%i in ("%%s_path%%\Edge Internal\Application\*"^) do if exist "%%%%i\installer\setup.exe" ^(
	echo :: Internal...
	echo start "" /w "%%%%i\installer\setup.exe" --uninstall --msedge-internal --system-level --verbose-logging --force-uninstall --delete-profile
	echo ^)

	echo :: Remove program entry
	echo reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge" /f
	echo reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft Edge Update" /f
	echo reg delete "HKEY_LOCAL_MACHINE\SOFTWARE\WOW6432Node\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft EdgeWebView" /f 

	echo :: Remove scheduled tasks and services
	echo schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineCore" /f
	echo schtasks /delete /tn "MicrosoftEdgeUpdateTaskMachineUA" /f
	echo sc config "MicrosoftEdgeElevationService" start=disabled
	echo sc config "edgeupdate" start=disabled
	echo sc config "edgeupdatem" start=disabled

	echo :: Remove edge
	echo sc delete "MicrosoftEdgeElevationService"
	echo sc delete "edgeupdate"
	echo sc delete "edgeupdatem"
	echo takeown /f "C:\Windows\SystemApps\*MicrosoftEdge*" /a /r /d Y
	echo icacls "C:\Windows\SystemApps\*MicrosoftEdge*" /grant Administrators:F /T /C
	echo cd /d "C:\Windows\SystemApps\*MicrosoftEdge*" ^&^& del /f /s /q *
	echo takeown /f "C:\Program Files\WindowsApps\*MicrosoftEdge*" /a /r /d Y
	echo icacls "C:\Program Files\WindowsApps\*MicrosoftEdge*" /grant Administrators:F /T /C
	echo cd /d "C:\Program Files\WindowsApps\*MicrosoftEdge*" ^&^& del /f /s /q *
	echo takeown /f "C:\Program Files (x86)\Microsoft\Edge" /a /r /d Y
	echo icacls "C:\Program Files (x86)\Microsoft\Edge" /grant Administrators:F /T /C
	echo cd /d "C:\Program Files (x86)\Microsoft\Edge" ^&^& del /f /s /q *
	echo takeown /f "C:\Program Files (x86)\Microsoft\EdgeCore" /a /r /d Y
	echo icacls "C:\Program Files (x86)\Microsoft\EdgeCore" /grant Administrators:F /T /C
	echo cd /d "C:\Program Files (x86)\Microsoft\EdgeCore" ^&^& del /f /s /q *
	echo takeown /f "C:\Program Files (x86)\Microsoft\EdgeUpdate" /a /r /d Y
	echo icacls "C:\Program Files (x86)\Microsoft\EdgeUpdate" /grant Administrators:F /T /C
	echo cd /d "C:\Program Files (x86)\Microsoft\EdgeUpdate" ^&^& del /f /s /q *
	echo takeown /f "C:\Program Files (x86)\Microsoft\EdgeWebView" /a /r /d Y
	echo icacls "C:\Program Files (x86)\Microsoft\EdgeWebView" /grant Administrators:F /T /C
	echo cd /d "C:\Program Files (x86)\Microsoft\EdgeWebView" ^&^& del /f /s /q *

	echo :: Remove shortcuts
	echo del /f /q "%%AppData%%\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge*.lnk"
	echo del /f /q "%%SystemRoot%%\System32\config\systemprofile\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\Microsoft Edge*.lnk"
	echo del /f /q "%%HOMEPATH%%\Desktop\Microsoft Edge*.lnk"
	echo del /f /q "%%ALLUSERSPROFILE%%\Microsoft\Windows\Start Menu\Programs\Microsoft Edge*.lnk"
) > "C:\Windows\uninstall_edge.bat"

(
	echo Set WshShell = CreateObject("WScript.Shell"^)
	echo WshShell.Run chr(34^) ^& "C:\Windows\uninstall_edge.bat" ^& Chr(34^), 0
	echo Set WshShell = Nothing
) > "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\uninstall_edge.vbs"

PAUSE

echo.
if %removeIE%==1 goto remove_IE
:return1

PAUSE

echo.
choice /C YN /N /M "The Microsoft Store may have been broken, check that it still works. Reinstall it? (requires internet) (this will download and install the latest version and its dependencies) [y/n]: "
if errorlevel 2 goto pass
echo Reinstalling the Microsoft Store...
powershell -Command "Get-AppxPackage *WindowsStore* | Remove-AppxPackage" 
powershell -Command "Set-ExecutionPolicy Unrestricted -Force"
powershell -Command "New-Item -ItemType Directory -Path '%TEMP%\WindowsStoreReinstall' -Force"
powershell -Command "Invoke-WebRequest -Uri 'https://raw.githubusercontent.com/IveMalfunctioned/NT-Scripts/main/Download-AppxPackage.ps1' -OutFile '%TEMP%\WindowsStoreReinstall\Download-AppxPackage.ps1'"
powershell -Command ". '%TEMP%\WindowsStoreReinstall\Download-AppxPackage.ps1'; Download-AppxPackage -URL 'https://www.microsoft.com/en-us/p/microsoft-store/9wzdncrfjbmp' -Path '%TEMP%\WindowsStoreReinstall'; Install-AppxFiles -Path '%TEMP%\WindowsStoreReinstall'"
del /f /s /q "%TEMP%\WindowsStoreReinstall" 2>nul
rmdir "%TEMP%\WindowsStoreReinstall"

:pass

echo.
echo Edge should be fully removed. Reset your default browser and restart Windows
:TheEnd
echo.
echo Press any key to exit.
pause >nul
exit

:remove_IE
echo Removing Internet Explorer...
dism /online /Disable-Feature /FeatureName:Internet-Explorer-Optional-amd64 /Quiet /NoRestart
cd /d "C:\Program Files\Internet Explorer" 2>nul && del /f /s /q * 2>nul
cd /d "C:\Program Files (x86)\Internet Explorer" 2>nul && del /f /s /q * 2>nul
goto return1