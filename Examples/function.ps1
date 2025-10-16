# ============================
# Script: Optellen.ps1
# Doel: Laat zien hoe een functie werkt
# ============================

# Functie die twee getallen optelt
function TelOp {
    param (
        [int]$Getal1,
        [int]$Getal2
    )

    $som = $Getal1 + $Getal2
    return $som
}

# --- Hoofdprogramma ---

# Eerste keer functie gebruiken
$uitkomst1 = TelOp -Getal1 5 -Getal2 10
Write-Host "De som van 5 en 10 is: $uitkomst1"

# Tweede keer functie gebruiken
$uitkomst2 = TelOp -Getal1 20 -Getal2 30
Write-Host "De som van 20 en 30 is: $uitkomst2"

# Derde keer functie gebruiken
$uitkomst3 = TelOp -Getal1 $uitkomst1 -Getal2 $uitkomst2
Write-Host "De som van de vorige twee resultaten is: $uitkomst3"
