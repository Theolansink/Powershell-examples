[CmdletBinding()]

# Vraag de gebruiker om twee getallen
$Getal1 = Read-Host "Voer het eerste getal in (kleiner 100)" 
$Getal2 = Read-Host "Voer het tweede getal in (kleiner 100)"

# Controleer of de invoer getallen zijn
if (-not ($Getal1 -as [int]) -or -not ($Getal2 -as [int])) {
    Write-Error "Beide invoeren moeten gehele getallen zijn!"
    # dit is dus een non-terminating error.
    return
}

# Zet om naar integers
$Getal1 = [int]$Getal1
$Getal2 = [int]$Getal2

# Geef een warning als een getal groter dan 100 is
if ($Getal1 -gt 100 -or $Getal2 -gt 100) {
    Write-Warning "Let op: Een van de getallen is groter dan 100!"
    # warnings worden getoond afh van variabele warningpreference 
}

# write-verbose
Write-Verbose "De ingevoerde getallen zijn: $Getal1 en $Getal2"
# verbose mssages worden getoond afh van variabele verbosepreference of parameter -Verbose bij aanroep. 


# (optellen getallen)
$Som = $Getal1 + $Getal2
Write-Output "De som van de getallen is: $Som"
