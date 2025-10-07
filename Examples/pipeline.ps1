<#
.SYNOPSIS
Voorbeelden van het gebruik van Get-Process met de PowerShell pipeline.

De voorbeelden zijn geordend op type pipeline-actie:
1. Selecteren van eigenschappen
2. Filteren van objecten
3. Acties uitvoeren
4. Output opslaan/exporteren
#>

# ----------------------------------------
# 1 Voorbeeld: Select-Object (eenvoudig)
# Alleen naam en CPU van alle processen tonen
# ----------------------------------------
Write-Host "=== Select-Object voorbeelden ==="
Get-Process | Select-Object Name, CPU

# Alleen naam en geheugen tonen
Get-Process | Select-Object Name, WorkingSet

# ----------------------------------------
# 2️ Voorbeeld: Where-Object
# Filter op processen die meer dan 100 MB geheugen gebruiken
# Filter processen met naam die "chrome" bevat
# ----------------------------------------
Write-Host "`n=== Where-Object voorbeelden ==="
Get-Process | Where-Object { $_.WorkingSet -gt 100MB }

Get-Process | Where-Object Name -like "*chrome*"

# ----------------------------------------
# 3️ Voorbeeld: ForEach-Object
# Doe iets met elk object in de pipeline
# Voorbeeld: informatie printen per proces met Write-Host
# ----------------------------------------
Write-Host "`n=== ForEach-Object voorbeelden ==="
Get-Process | ForEach-Object { Write-Host "$($_.Name) gebruikt $($_.WorkingSet/1MB) MB" }

# Voorbeeld: stop notepad-processen (uitgeschakeld, alleen als commentaar)
# Get-Process | Where-Object Name -eq "notepad" | ForEach-Object { Stop-Process -Id $_.Id }

# ----------------------------------------
# 4️ Voorbeeld: Output opslaan/exporteren
# Opslaan in variabele
# Exporteren naar CSV
# Exporteren naar JSON
# ----------------------------------------
Write-Host "`n=== Output voorbeelden ==="

# Opslaan in variabele
$topCPUProcesses = Get-Process | Sort-Object CPU -Descending | Select-Object -First 5
Write-Host "Top 5 CPU-processen (in variabele):"
$topCPUProcesses

# Exporteren naar CSV
Get-Process | Select-Object Name, CPU, WorkingSet | Export-Csv "processes.csv" -NoTypeInformation
Write-Host "Processes geëxporteerd naar processes.csv"

# Exporteren naar JSON
$json = Get-Process | Select-Object Name, CPU, WorkingSet | ConvertTo-Json
Write-Host "Processes geëxporteerd naar JSON:"
Write-Host $json

# ----------------------------------------
# Combinatievoorbeeld: filter, sorteer en selecteer
# Top 5 geheugenintensieve Chrome-processen
# ----------------------------------------
Write-Host "`n=== Combinatie: Top 5 geheugenintensieve Chrome-processen ==="
Get-Process | Where-Object Name -like "*chrome*" |
    Sort-Object WorkingSet -Descending |
    Select-Object -First 5 Name, WorkingSet

# ----------------------------------------
# Extra: Totaal CPU-gebruik van alle processen
# ----------------------------------------
Write-Host "`n=== Totaal CPU-gebruik van alle processen ==="
write-host "(get-process | Measure-Object -Property cpu -Sum).sum"
(get-process | Measure-Object -Property cpu -Sum).sum

write-host "anders uitgevoerd:"
Write-host '$measure = get-process | Measure-Object -Property cpu -Sum'
write-host '$measure.sum'
$measure = get-process | Measure-Object -Property cpu -Sum
$measure.sum