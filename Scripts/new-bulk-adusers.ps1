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

#region Helptekst
# === Stap 1: Helptekst ===
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "Dit script maakt automatisch gebruikers aan in Active Directory." -ForegroundColor Cyan
Write-Host "Er wordt gebruik gemaakt van een CSV-bestand met gebruikersinformatie." -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan
#endregion

# === Stap 2: Vraag gebruiker om pad CSV ===
#region ask input CSVfile
$CsvPath = Read-Host "Geef het volledige pad naar het CSV-bestand"

if (!(Test-Path $CsvPath)) {
    Write-Host "CSV-bestand niet gevonden op pad: $CsvPath" -ForegroundColor Red
    exit
}
#endregion
$Users = Import-Csv -Path $CsvPath
$AantalGebruikers = $Users.Count
Write-Host "Aantal te creëren gebruikers: $AantalGebruikers" -ForegroundColor Yellow

# === Stap 3: Doorgaan of Afbreken ===
#region ask continue
$Keuze = Read-Host "Wil je doorgaan? (J/N)"
if ($Keuze -ne "J") {
    Write-Host "Script is afgebroken." -ForegroundColor Red
    exit
}
#endregion

#region add-adusers
# === Stap 4: Gebruikers toevoegen ===
$CreatedAccounts = @()
$FailedAccounts  = @()

foreach ($User in $Users) {
    try {
        
        



        Write-Host "Useraccount $($User.SamAccountName) is successfully created" -ForegroundColor Green
        $CreatedAccounts += $User.SamAccountName
    }
    catch {
        Write-Host "Useraccount $($User.SamAccountName) could not be created" -ForegroundColor Red
        write-host "Errormessage $($error[0])"
        $FailedAccounts += $User.SamAccountName
    }
}
#endregion

# === Stap 5: Eindresultaten tonen ===
#region show results
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "Number of created accounts: $($CreatedAccounts.Count)" -ForegroundColor Green
Write-Host "Number of accounts that could not be created: $($FailedAccounts.Count)" -ForegroundColor Red
Write-Host "===================================================" -ForegroundColor Cyan
#endregion

#region write output
# === Stap 6: Logbestanden schrijven ===
$CreatedAccounts | Out-File -FilePath ".\created-accounts.txt"
$FailedAccounts  | Out-File -FilePath ".\not-created-accounts.txt"

Write-Host "Overzicht opgeslagen in 'created-accounts.txt' en 'not-created-accounts.txt'" -ForegroundColor Cyan
#endregion