function New-ADUsersFromCsv {
<#
.SYNOPSIS
    Maakt automatisch gebruikers aan in Active Directory op basis van een CSV-bestand.

.DESCRIPTION
    - Leest een CSV-bestand met gebruikersgegevens
    - Toont een overzicht van te creëren accounts
    - Vraagt om bevestiging voordat accounts worden aangemaakt
    - Maakt accounts aan, activeert ze en forceert password reset bij eerste login
    - Geeft per gebruiker terug of het gelukt is of niet
    - Schrijft lijsten met succesvolle en mislukte accounts naar bestanden

.PARAMETER CsvPath
    Het volledige pad naar het CSV-bestand met gebruikersinformatie.

.PARAMETER DefaultPassword
    Het wachtwoord dat wordt ingesteld bij aanmaak van de gebruiker.

.EXAMPLE
    New-ADUsersFromCsv -CsvPath "C:\Temp\Users.csv" -DefaultPassword "Welkom123!"

#>
 [CmdletBinding()]   # dit voegt extra cmdlet-achtige features toe als pipelining, erroraction etc
    param (
        [Parameter(Mandatory = $true)]
        [string]$CsvPath,

        [Parameter(Mandatory = $true)]
        [string]$DefaultPassword
    )

    # Controleer CSV-bestand
    if (!(Test-Path $CsvPath)) {
        Write-Error "CSV-bestand niet gevonden op pad: $CsvPath"
        return
    }

    $Users = Import-Csv -Path $CsvPath
    $AantalGebruikers = $Users.Count

    Write-Host "Aantal te creëren gebruikers: $AantalGebruikers" -ForegroundColor Yellow

    $Keuze = Read-Host "Wil je doorgaan? (J/N)"
    if ($Keuze -ne "J") {
        Write-Host "Cmdlet is afgebroken." -ForegroundColor Red
        return
    }

    $CreatedAccounts = @()
    $FailedAccounts  = @()

    foreach ($User in $Users) {
        try {
            New-ADUser `
                -SamAccountName $User.SamAccountName `
                -UserPrincipalName "$($User.SamAccountName)@orcsnest.uk" `
                -GivenName $User.FirstName `
                -Surname $User.LastName `
                -Name "$($User.FirstName) $($User.LastName)" `
                -AccountPassword (ConvertTo-SecureString $DefaultPassword -AsPlainText -Force) `
                -Enabled $false `
                -ChangePasswordAtLogon $true `
                -ErrorAction Stop

            Write-Host "Useraccount $($User.SamAccountName) is successfully created" -ForegroundColor Green
            $CreatedAccounts += $User.SamAccountName
        }
        catch {
            Write-Host "Useraccount $($User.SamAccountName) could not be created" -ForegroundColor Red
            $FailedAccounts += $User.SamAccountName
        }
    }

    # Eindresultaten tonen
    Write-Host "===================================================" -ForegroundColor Cyan
    Write-Host "Number of created accounts: $($CreatedAccounts.Count)" -ForegroundColor Green
    Write-Host "Number of accounts that could not be created: $($FailedAccounts.Count)" -ForegroundColor Red
    Write-Host "===================================================" -ForegroundColor Cyan

    # Logbestanden schrijven
    $Timestamp = Get-Date -Format "yyyyMMdd_HHmmss"
    $CreatedAccounts | Out-File -FilePath ".\created-accounts_$Timestamp.txt"
    $FailedAccounts  | Out-File -FilePath ".\not-created-accounts_$Timestamp.txt"

    Write-Host "Overzicht opgeslagen in 'created-accounts_$Timestamp.txt' en 'not-created-accounts_$Timestamp.txt'" -ForegroundColor Cyan
}
