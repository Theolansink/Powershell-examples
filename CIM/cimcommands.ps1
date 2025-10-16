# most important CIM commands
# CIM wordt met name gebruikt om systeeminformatie (hardware, software, Services etc) uit te lezen 
# Dit script toont namespaces, classes en enkele belangrijke instances in CIM

# 1. Alle namespaces onder root ophalen
# Zijn er erg veel. CIMv2 namespace is de belangrijkste.

Write-Host "`n=== Namespaces onder root ===" -ForegroundColor Cyan
$namespaces = Get-CimInstance -Namespace root -ClassName __Namespace
$namespaces | Select-Object Name | Format-Table -AutoSize

# 2. Alle classes in root\cimv2 ophalen
# Zijn er ook erg veel. Classes die beginnen met win32_ zijn de belangrijkste.
Write-Host "`n=== Classes in root\cimv2 ===" -ForegroundColor Cyan
$classes = Get-CimClass -Namespace root\cimv2
$classes | Select-Object CimClassName | Format-Table -AutoSize

# 3. Belangrijke Win32_ classes filteren
Write-Host "`n=== Belangrijke Win32_ classes ===" -ForegroundColor Cyan
$win32classes = Get-CimClass -Namespace root\cimv2 -ClassName Win32_*
$win32classes | Select-Object CimClassName | Format-Table -AutoSize

# 4. Voorbeelden van instances ophalen. Instances tonen de daadwerkelijk gezochte informatie.
Write-Host "`n=== Voorbeeld instances (alle properties) ===" -ForegroundColor Cyan

# Operating System
Write-Host "`n-- Win32_OperatingSystem --" -ForegroundColor Yellow
Get-CimInstance -ClassName Win32_OperatingSystem | Format-List *

# Physical Memory
Write-Host "`nPhysicalMemory --" -ForegroundColor Yellow
Get-CimInstance -ClassName Win32_PhysicalMemory | Format-List *

# Processors
Write-Host "`n-- Win32_Processor --" -ForegroundColor Yellow
Get-CimInstance -ClassName Win32_Processor | Format-List *

# Services (running)
Write-Host "`n-- Win32_Service (Running) --" -ForegroundColor Yellow
Get-CimInstance -ClassName Win32_Service | Where-Object { $_.State -eq "Running" }

# BIOS
Write-Host "`n-- Win32_BIOS --" -ForegroundColor Yellow
Get-CimInstance -ClassName Win32_BIOS | Format-List *

# Toon alle methoden van een class
Write-Host "`n=== Methoden class Win32_operatingSystem ===" -ForegroundColor Cyan
$class = Get-CimClass -ClassName Win32_OperatingSystem -Namespace root\cimv2
$class.CimClassMethods | Format-List *


# Ook mogelijk om CIM-informatie op te vragen van andere host.
 Get-CimInstance -ClassName Win32_OperatingSystem -ComputerName LON-DC1

 # of een commando (methode)uit te voeren:
 # Invoke-CimMethod -ClassName Win32_OperatingSystem -ComputerName LON-DC1 -MethodName Reboot
