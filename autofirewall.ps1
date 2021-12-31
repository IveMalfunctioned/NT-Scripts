#Known Problem: An input directory with a period in it will not work properly

if (-NOT ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole(`
[Security.Principal.WindowsBuiltInRole] "Administrator")) {
Write-Warning "You need administrator priviledges to run this script. Please re-run it as administrator!"
PAUSE
Break
}
else {
  # Singlular programs
  #   $programs = @(
  #     "C:\Program Files\Internet Explorer\iexplore.exe"
  #   )

  #   $programName = Split-Path $programs -leaf

  #   foreach ($program in $programs) {
  #     New-NetFirewallRule -DisplayName "Block $programName from the internet" -Direction Inbound -Program "$program" -Action Block
  #     New-NetFirewallRule -DisplayName "Block $programName from the internet" -Direction Outbound -Program "$program" -Action Block
  #     Write-Output "Created firewall rule to block $programName from accessing the internet"
  #   }

  #Every .exe in a directory and its subdirectories (Remove "-Recurse" to exclude subdirectories)

  $directories = "C:\Program Files\Internet Explorer", "C:\Program Files (x86)\Microsoft\Edge"

  $lists = Get-ChildItem -Path $directories -Recurse -Filter *.exe | % { $_.FullName }
  $separator = ".exe","."
  $option = [System.StringSplitOptions]::RemoveEmptyEntries
  $pro_grams = ($lists.Split($separator, 9999, $option).Trim() | ForEach-Object { $_+'.exe' })
  foreach ($pro_gram in $pro_grams) {
      New-NetFirewallRule -DisplayName "Block internet access: $pro_gram" -Direction Inbound -Program "$pro_gram" -Action Block
      New-NetFirewallRule -DisplayName "Block internet access: $pro_gram" -Direction Outbound -Program "$pro_gram" -Action Block
      Write-Output "Created firewall rule to block $pro_gram from accessing the internet"
    }
}

PAUSE