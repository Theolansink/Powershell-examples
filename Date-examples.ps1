# --------------------------------------------
# PowerShell Script: Date & Time Examples
# --------------------------------------------

# Huidige datum en tijd
$now = Get-Date
Write-Host "Huidige datum en tijd: $now"

# Specifieke datum maken
$birthday = Get-Date -Year 1990 -Month 5 -Day 23
Write-Host "Specifieke datum: $birthday"

# Datumformatering
Write-Host "Datum in kort formaat: $($now.ToShortDateString())"
Write-Host "Datum in lang formaat: $($now.ToLongDateString())"
Write-Host "Tijd in kort formaat: $($now.ToShortTimeString())"
Write-Host "Tijd in lang formaat: $($now.ToLongTimeString())"

# Datum en tijd aanpassen
$tomorrow = $now.AddDays(1)
$nextWeek = $now.AddDays(7)
$nextMonth = $now.AddMonths(1)
$nextYear = $now.AddYears(1)
Write-Host "Morgen: $tomorrow"
Write-Host "Volgende week: $nextWeek"
Write-Host "Volgende maand: $nextMonth"
Write-Host "Volgend jaar: $nextYear"

# Tijdsverschillen berekenen
$start = Get-Date "2025-01-01"
$end = Get-Date "2025-12-31"
$diff = $end - $start
Write-Host "Verschil tussen $start en $end: $($diff.Days) dagen"

# Datum vergelijken
if ($now -gt $birthday) {
    Write-Host "De huidige datum is na mijn verjaardag"
} else {
    Write-Host "De huidige datum is voor mijn verjaardag"
}

# Zoek alle gebruikers die in de laatste 6 maanden NIET hebben ingelogd
# Bereken de datum van 6 maanden geleden
$sixMonthsAgo = $now.AddMonths(-6)

$inactiveUsers = Get-ADUser -Filter * -Properties LastLogonDate | Where-Object {
    ($_.LastLogonDate -eq $null) -or ($_.LastLogonDate -lt $sixMonthsAgo)
}

# Weekdag en maand ophalen
Write-Host "Vandaag is het: $($now.DayOfWeek)"
Write-Host "Deze maand is: $($now.Month)"

