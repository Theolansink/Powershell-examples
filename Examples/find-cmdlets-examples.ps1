# ===========================
# Workflow: Cmdlet ontdekken en gebruiken
# Voorbeeld: zoeken om user aan te maken in AD
# sommige commando's hieronder werken alleen op een AD
# ===========================

# ---------------------------
# 1️⃣ Zoek cmdlets die met 'user' te maken hebben
# ---------------------------
Write-Host "`n=== 1. Cmdlet zoeken ==="
# Zoek alle cmdlets die 'user' in de naam hebben
Get-Command *user*

# ---------------------------
# Bekijk help voor de cmdlet New-ADUser
# ---------------------------
Write-Host "`n=== 2. Help informatie ophalen ==="
# Basis help
Get-Help New-ADUser

# Gedetailleerde help met parameters en uitleg
Get-Help New-ADUser -Detailed

# Voorbeelden van gebruik
Get-Help New-ADUser -Examples

# Volledige help inclusief technische info
Get-Help New-ADUser -Full

# ---------------------------
# Bekijk welke objecten teruggegeven worden (properties & methods)
# ---------------------------
Write-Host "`n=== 3. Inspecteer objecten ==="
# New-ADUser geeft standaard niets terug, gebruik -PassThru om object te krijgen
$voorbeeldUser = New-ADUser -Name "TestUser" -PassThru

# Bekijk properties en methods van het object
$voorbeeldUser | Get-Member

# Alleen properties
$voorbeeldUser | Get-Member -MemberType Property

# Alleen methods
$voorbeeldUser | Get-Member -MemberType Method

# ---------------------------
# Bekijk en gebruik properties
# ---------------------------
Write-Host "`n=== 4. Properties bekijken ==="
Write-Host "SamAccountName: $($voorbeeldUser.SamAccountName)"
Write-Host "Name: $($voorbeeldUser.Name)"
Write-Host "UserPrincipalName: $($voorbeeldUser.UserPrincipalName)"

# ---------------------------
# Bekijk mogelijke methods (voor geavanceerd gebruik)
# ---------------------------
Write-Host "`n=== 5. Beschikbare methods ==="
$voorbeeldUser | Get-Member -MemberType Method

# ---------------------------
# Concrete voorbeeld van cmdlet gebruik
# ---------------------------
Write-Host "`n=== 6. Voorbeeld New-ADUser gebruik ==="
Write-Host @"
New-ADUser `
    -Name 'Nieuwe Gebruiker' `
    -GivenName 'Test' `
    -Surname 'User' `
    -SamAccountName 'testuser' `
    -UserPrincipalName 'testuser@domain.com' `
    -Path 'OU=Users,DC=domain,DC=com' `
    -AccountPassword (ConvertTo-SecureString 'P@ssw0rd' -AsPlainText -Force) `
    -Enabled $true
"@
