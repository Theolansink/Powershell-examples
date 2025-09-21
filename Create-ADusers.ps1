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

# Zorg dat de ActiveDirectory module beschikbaar is
Import-Module ActiveDirectory -ErrorAction Stop

# === Stap 1: Helptekst ===
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "Dit script maakt automatisch gebruikers aan in Active Directory." -ForegroundColor Cyan
Write-Host "Er wordt gebruik gemaakt van een CSV-bestand met gebruikersinformatie." -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan

# === Stap 2: Vraag gebruiker om pad CSV ===
$CsvPath = Read-Host "Geef het volledige pad naar het CSV-bestand"

if (!(Test-Path $CsvPath)) {
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
    try {
        New-ADUser `
            -SamAccountName $User.SamAccountName `
            -UserPrincipalName "$($User.SamAccountName)@domain.local" `
            -GivenName $User.GivenName `
            -Surname $User.Surname `
            -Name "$($User.GivenName) $($User.Surname)" `
            -Path $User.OU `
            -AccountPassword (ConvertTo-SecureString $User.Password -AsPlainText -Force) `
            -ChangePasswordAtLogon $true `
            -Enabled $true -ErrorAction Stop

        Write-Host "Useraccount $($User.SamAccountName) is successfully created" -ForegroundColor Green
        $CreatedAccounts += $User.SamAccountName
    }
    catch {
        Write-Host "Useraccount $($User.SamAccountName) could not be created" -ForegroundColor Red
        $FailedAccounts += $User.SamAccountName
    }
}

# === Stap 5: Eindresultaten tonen ===
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "Number of created accounts: $($CreatedAccounts.Count)" -ForegroundColor Green
Write-Host "Number of accounts that could not be created: $($FailedAccounts.Count)" -ForegroundColor Red
Write-Host "===================================================" -ForegroundColor Cyan

# === Stap 6: Logbestanden schrijven ===
$CreatedAccounts | Out-File -FilePath ".\created-accounts.txt" -Encoding UTF8
$FailedAccounts  | Out-File -FilePath ".\not-created-accounts.txt" -Encoding UTF8

Write-Host "Overzicht opgeslagen in 'created-accounts.txt' en 'not-created-accounts.txt'" -ForegroundColor Cyan
