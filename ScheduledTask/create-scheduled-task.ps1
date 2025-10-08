# Pad naar je script dat de functie bevat
$scriptPath = "D:\Powershell\get-highsecurityeventsdaily.ps1"
$taskName = "Get-HighSeverityEventsDaily"
$time = "18:00"

# Actie: powershell.exe starten en script uitvoeren
$action = New-ScheduledTaskAction -Execute "pwsh" -Argument "-ExecutionPolicy Bypass -File `"$scriptPath`""

# Trigger: dagelijks om 18:00
$trigger = New-ScheduledTaskTrigger -Daily -At $time

# Optioneel: taak laten draaien als SYSTEM met hoogste rechten
$principal = New-ScheduledTaskPrincipal -UserId "SYSTEM" -RunLevel Highest

# Taak registreren
Register-ScheduledTask -TaskName $taskName -Action $action -Trigger $trigger -Principal $principal -Description "Verzamelt high severity events dagelijks om 18:00 uur"