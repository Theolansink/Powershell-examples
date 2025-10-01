# --------------------------------------------
# PowerShell Script: Quotes, Speciale Karakters en Operators
# --------------------------------------------

# ============================================
# 🔹 Dubbele quotes (" ")
# ============================================
Write-Host "`n=== Dubbele quotes ("" "") ===`n"

$naam = "Jan"
Write-Host "Met dubbele quotes worden variabelen geïnterpoleerd:"
Write-Host "Hallo $naam"

Write-Host "Ook escapes zoals `n en `t werken binnen dubbele quotes:"
Write-Host "Regel1`nRegel2"
Write-Host "Kolom1`tKolom2"

# ============================================
# 🔹 Enkele quotes (' ')
# ============================================
Write-Host "`n=== Enkele quotes (' ') ===`n"

Write-Host "Met enkele quotes wordt alles letterlijk genomen:"
Write-Host 'Hallo $naam (wordt niet vervangen)'
Write-Host 'Escapes werken niet, dit is letterlijk `n en `t'

# ============================================
# 🔹 Backtick (`) - escape character
# ============================================
Write-Host "`n=== Backtick (`) ===`n"

Write-Host "Backtick is het escape character in PowerShell:"
Write-Host "Nieuwe regel:`nRegel1`nRegel2"
Write-Host "Tab:`tKolom1`tKolom2"

Write-Host "Dubbele quote: `"Hallo`""
Write-Host 'Enkele quote: `''Hallo`'' '
Write-Host "Letterlijke backtick: ``"

Write-Host "Ook te gebruiken voor line continuation:"
Write-Host "Eerste proces:"
$ps1 = Get-Process | `
    Where-Object { $_.CPU -gt 0 } | `
    Select-Object -First 1
Write-host "$($ps1.name)"
