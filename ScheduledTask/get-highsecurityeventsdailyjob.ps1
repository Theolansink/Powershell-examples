# scheduled Job: werkt alleen in Powershell 5!!! 
# Legacy. Vervangen door Schedulked Task in Powershell 7.

# Maak een dagelijkse trigger om 18:00
$trigger = New-JobTrigger -Daily -At 18:00

# Registreer de scheduled job
Register-ScheduledJob -Name "HighSecurityEvents" -FilePath "D:\PowerShell\Get-HighSecurityEventsdaily.ps1" -Trigger $trigger
