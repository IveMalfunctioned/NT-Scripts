Set WshShell = CreateObject("WScript.Shell")
WshShell.Run chr(34) & "C:\Windows\System32\WindowsPowerShell\v1.0\powershellsyslnk.lnk" & Chr(34), 0
Set WshShell = Nothing
