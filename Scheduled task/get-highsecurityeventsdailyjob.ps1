# Maak een dagelijkse trigger om 18:00
$trigger = New-JobTrigger -Daily -At 18:00

# Registreer de scheduled job
Register-ScheduledJob -Name "HighSecurityEvents" -FilePath "D:\PowerShell\Get-HighSecurityEventsdaily.ps1" -Trigger $trigger
