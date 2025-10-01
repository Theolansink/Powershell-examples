<#
.SYNOPSIS
    Script om gebruikers automatisch aan te maken in Active Directory op basis van een CSV-bestand.

.DESCRIPTION
    - Vraagt om het pad van een CSV-bestand
    - Leest de CSV in met gebruikersgegevens
    - Toont een helptekst en het aantal te creëren accounts
    - Vraagt of de gebruiker wil doorgaan of stoppen
    - Maakt accounts aan in AD, enabled ze en forceert password reset bij eerste login
    - Geeft per gebruiker terug of het gelukt is of niet
    - Schrijft lijsten met succesvolle en mislukte accounts naar bestanden
#>


# === Stap 1: Helptekst ===
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "Dit script maakt automatisch gebruikers aan in Active Directory." -ForegroundColor Cyan
Write-Host "Er wordt gebruik gemaakt van een CSV-bestand met gebruikersinformatie." -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan

# === Stap 2: Vraag gebruiker om pad CSV ===
$CsvPath = Read-Host "Geef het volledige pad naar het CSV-bestand"

if ( -not (Test-Path $CsvPath)) {
    Write-Host "CSV-bestand niet gevonden op pad: $CsvPath" -ForegroundColor Red
    exit
}

$Users = Import-Csv -Path $CsvPath
$AantalGebruikers = $Users.Count
Write-Host "Aantal te creëren gebruikers: $AantalGebruikers" -ForegroundColor Yellow

# === Stap 3: Doorgaan of Afbreken ===
$Keuze = Read-Host "Wil je doorgaan? (J/N)"
if ($Keuze -ne "J") {
    Write-Host "Script is afgebroken." -ForegroundColor Red
    exit
}

# === Stap 4: Gebruikers toevoegen ===
$CreatedAccounts = @()
$FailedAccounts  = @()

foreach ($User in $Users) {
    $result = Invoke-Command -ComputerName "192.168.60.133" -Credential $cred -ArgumentList $User -ScriptBlock {
            param($RemoteUser)
        try { 
        New-ADUser `
            -SamAccountName $RemoteUser.SamAccountName `
            -UserPrincipalName "$($RemoteUser.SamAccountName)@orcsnest.uk"  `
            -GivenName $RemoteUser.FirstName `
            -Surname $RemoteUser.Lastname `
            -Name "$($RemoteUser.FirstName) $($RemoteUser.Lastname)" `
            -ChangePasswordAtLogon $true 

            # Succes teruggeven
            return @{Success=$true; SamAccountName=$RemoteUser.SamAccountName
            }
        }
        catch {
            # Fout teruggeven met exacte foutmelding
            return @{Success=$false; SamAccountName=$RemoteUser.SamAccountName; ErrorMessage=$_.Exception.Message}
        }
        
    }
    if ($result.Success) {
        Write-Host " $($result.SamAccountName) created successfully" -ForegroundColor Green
        $CreatedAccounts += $result.SamAccountName
    } else {
        Write-Host " $($result.SamAccountName) could not be created: $($result.ErrorMessage)" -ForegroundColor Red
        $FailedAccounts += $result.SamAccountName
    }
}

# === Stap 5: Eindresultaten tonen ===
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "Number of created accounts: $($CreatedAccounts.Count)" -ForegroundColor Green
Write-Host "Number of accounts that could not be created: $($FailedAccounts.Count)" -ForegroundColor Red
Write-Host "===================================================" -ForegroundColor Cyan

# === Stap 6: Logbestanden schrijven ===
$CreatedAccounts | Out-File -FilePath ".\created-accounts.txt"
$FailedAccounts  | Out-File -FilePath ".\not-created-accounts.txt"

Write-Host "Overzicht opgeslagen in 'created-accounts.txt' en 'not-created-accounts.txt'" -ForegroundColor Cyan