# ==========================================================
# Client testscript voor PowerShell Remoting (één server)
# Draai dit script op de Windows 11 machine
# ==========================================================

param(
    [string]$Server = "192.168.60.133"   # Pas aan naar jouw servernaam of IP
)

Write-Host "=== Test verbinding naar $Server ===" -ForegroundColor Cyan

# Voeg server toe aan TrustedHosts als nodig (voor workgroup scenario)
if (-not (Test-Path WSMan:\localhost\Client\TrustedHosts)) {
    New-Item -Path WSMan:\localhost\Client\TrustedHosts -Force | Out-Null
}

$trustedHosts = (Get-Item WSMan:\localhost\Client\TrustedHosts).Value
if (-not $trustedHosts -or -not $trustedHosts.Contains($Server)) {
    Set-Item WSMan:\localhost\Client\TrustedHosts -Value $Server -Force
    Write-Host "Toegevoegd aan TrustedHosts: $Server"
}

# Test verbinding
try {
    Test-WsMan -ComputerName $Server -ErrorAction Stop
    Write-Host " Verbinding geslaagd: $Server is klaar voor remoting"
}
catch {
    Write-Host " Verbinding mislukt met $Server"
    Write-Host "   Details: $($_.Exception.Message)"
}
