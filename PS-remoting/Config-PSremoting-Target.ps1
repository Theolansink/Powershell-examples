# ==========================================================
# Server configuratie voor PowerShell Remoting
# Draai dit script als Administrator op de Windows Server
# ==========================================================

Write-Host "=== Configuratie van PowerShell Remoting op deze server ==="

# 1. Zet PowerShell Remoting aan (maakt WinRM listener aan)
Enable-PSRemoting -Force

# 2. Open firewallregels voor Windows Remote Management
Enable-NetFirewallRule -DisplayGroup "Windows Remote Management"

# 3. Controleer of WinRM service draait
$service = Get-Service -Name WinRM
if ($service.Status -ne 'Running') {
    Start-Service -Name WinRM
    Write-Host "WinRM service is gestart."
} else {
    Write-Host "WinRM service draait al."
}

# 4. Test lokaal of WinRM werkt
try {
    Test-WsMan -ComputerName localhost -ErrorAction Stop
    Write-Host " Lokale WinRM test geslaagd — deze server accepteert remoting"
}
catch {
    Write-Host " Lokale WinRM test mislukt!"
    Write-Host "   Details: $($_.Exception.Message)"
}
