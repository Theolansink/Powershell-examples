# ===========================
# Arrays declareren
# ===========================
$numbers = 1, 2, 3, 4, 5
$fruits = @("Appel", "Banaan", "Kers")

Write-Host "Oorspronkelijke arrays:"
Write-Host "Numbers: $numbers"
Write-Host "Fruits: $fruits"
Write-Host ""

# ===========================
# Elementen toevoegen
# ===========================
$numbers += 6
$fruits += "Druif"

Write-Host "Na toevoegen:"
Write-Host "Numbers: $numbers"
Write-Host "Fruits: $fruits"
Write-Host ""

# ===========================
# Elementen verwijderen (is eigenlijk nieuwe array aanmaken zonder verwijderde elementen)
# ===========================
$numbers = $numbers | Where-Object { $_ -ne 3 }

Write-Host "Na verwijderen van 3:"
Write-Host "Numbers: $numbers"
Write-Host ""

# ===========================
# Sorteren
# ===========================
$sortedNumbers = $numbers | Sort-Object
$sortedFruits = $fruits | Sort-Object

Write-Host "Gesorteerd:"
Write-Host "Numbers: $sortedNumbers"
Write-Host "Fruits: $sortedFruits"
Write-Host ""

# ===========================
# Omgekeerde volgorde
# ===========================
$reversedNumbers = $numbers[($numbers.Length-1)..0]

Write-Host "Omgekeerde volgorde van Numbers:"
Write-Host $reversedNumbers
Write-Host ""

# ===========================
# Unieke waarden
# ===========================
$mixed = 1,2,2,3,3,4,5,5
$unique = $mixed | Sort-Object -Unique

Write-Host "Unieke waarden uit (1,2,2,3,3,4,5,5):"
Write-Host $unique
Write-Host ""

# ===========================
# Indexeren
# ===========================
Write-Host "Eerste fruit: $($fruits[0])"
Write-Host "Laatste getal: $($numbers[-1])"
Write-Host ""

# ===========================
# Array doorlopen
# ===========================
Write-Host "Alle fruits doorlopen:"
foreach ($fruit in $fruits) {
    Write-Host "- $fruit"
}
Write-Host ""

# ===========================
# Array-operatoren
# ===========================
Write-Host "Aantal elementen (Count): $($numbers.Count)"
Write-Host "Aantal elementen (Length): $($numbers.Length)"

Write-Host "Maximum van Numbers: $(($numbers | Measure-Object -Maximum ).Maximum)"
Write-Host "Minimum van Numbers: $(($numbers | Measure-Object -Minimum ).Minimum)" 
# andere notatie Measure-objects met Select-Object
Write-Host "Som van Numbers: $($numbers | Measure-Object -Sum | Select-Object -ExpandProperty Sum)"
Write-Host "Gemiddelde van Numbers: $($numbers | Measure-Object -Average | Select-Object -ExpandProperty Average)"

Write-host "Gemiddelde CPU gebruik processen: $(get-process | measure-object -property cpu -Average | select-object -ExpandProperty Average)"