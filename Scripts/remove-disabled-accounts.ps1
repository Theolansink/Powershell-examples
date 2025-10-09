<#
.SYNOPSIS
    Script to remove disables accounts from Active Direectory.

.DESCRIPTION
    - Show helptext and accounts to be removed
    - Asks confirmation to continue or stop
    - Removes the accounts
    - Show how many accounts are removed
    - Creates a list of removed accounts
#>


# === Stap 1: Helptekst ===
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "This script removes disabled accounts from Active Directory." -ForegroundColor Cyan
Write-Host "===================================================" -ForegroundColor Cyan

$Users = get-aduser -filter {enabled -eq $false}
Write-Host "Nr of disabled users: " $Users.Count -ForegroundColor Yellow
Write-host "Users to be deleted:"
$users | Write-Host

# === Stap 3: Doorgaan of Afbreken ===
$choice = Read-Host "Remove users and continue? (J/N)"
if ($choice -ne "J") {
    Write-Host "Script is cancelled." -ForegroundColor Red
    exit
}

# === Stap 4: Remove users ===
$RemovedAccounts = @()
$notRemovedAccounts = @()

foreach ($User in $Users) {
    try {
        Remove-ADUser -Identity $User.DistinguishedName -Confirm:$false -ErrorAction Stop

        Write-Host "Useraccount $($User.SamAccountName) is successfully deleted" -ForegroundColor Green
        $RemovedAccounts += $User.SamAccountName
    }
    catch {
        Write-Host "Useraccount $($User.SamAccountName) could not be removed" -ForegroundColor Red
        $NotRemovedAccounts += $User.SamAccountName
    }
}

# === Stap 5: Show results ===
Write-Host "===================================================" -ForegroundColor Cyan
Write-Host "Number of removed accounts: $($RemovedAccounts.Count)" -ForegroundColor Green
Write-Host "Number of accounts that could not be removed: $($NotRemovedAccounts.Count)" -ForegroundColor Red
Write-Host "===================================================" -ForegroundColor Cyan

# === Stap 6: Logbestanden schrijven ===
$RemovedAccounts | Out-File -FilePath ".\removedAccounts.txt"
$NotRemovedAccounts  | Out-File -FilePath ".\notRemovedAccounts.txt"

Write-Host "Results are in 'removedAccounts.txt' en 'notRemovedAccounts.txt'" -ForegroundColor Cyan