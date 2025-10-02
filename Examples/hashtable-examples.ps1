# ===========================
# PowerShell Hashtable Voorbeelden (Artikel)
# ===========================

# ---------------------------
# Eenvoudige Hashtable
# ---------------------------

# 1️⃣ Maak een eenvoudige hashtable voor een artikel
$artikel = @{
    Titel      = "PowerShell Gids"
    Prijs      = 49.99
    Categorie  = "Boeken"
}

# Toegang tot waarden
Write-Host "Dot-syntax: Titel = $($artikel.Titel)"
Write-Host "Indexer-syntax: Prijs = $($artikel["Prijs"])`n"

# ---------------------------
# Toevoegen, Wijzigen en Verwijderen
# ---------------------------

# Voeg een nieuwe key-value toe
$artikel.Auteur = "Alice"
Write-Host "Toegevoegd Auteur: $($artikel.Auteur)"

# Wijzig een bestaande waarde
$artikel["Categorie"] = "Programmeren"
Write-Host "Gewijzigde Categorie: $($artikel.Categorie)"

# Verwijder een key
$artikel.Remove("Prijs")
Write-Host "Huidige keys na verwijderen Prijs: $($artikel.Keys -join ', ')`n"

# ---------------------------
# Itereren door Hashtable
# ---------------------------

Write-Host "Itereren door het artikel:"
foreach ($key in $artikel.Keys) {
    Write-Host "$key => $($artikel[$key])"
}
Write-Host ""

# ---------------------------
# Array van Hashtables
# ---------------------------

$artikelen = @(
    @{ Titel = "PowerShell Gids"; Categorie = "Programmeren"; Auteur = "Alice" },
    @{ Titel = "Linux Handleiding"; Categorie = "IT"; Auteur = "Bob" }
)

Write-Host "Array van artikelen:"
foreach ($a in $artikelen) {
    Write-Host "Titel: $($a.Titel), Categorie: $($a.Categorie), Auteur: $($a.Auteur)"
}
Write-Host ""

# ---------------------------
# Controleren of Key Bestaat
# ---------------------------

if ($artikel.ContainsKey("Titel")) {
    Write-Host "De key 'Titel' bestaat en heeft waarde: $($artikel["Titel"])"
}
Write-Host ""

# ---------------------------
# Nested Hashtable
# ---------------------------

$artikelGedetailleerd = @{
    Titel      = "PowerShell Gids"
    Categorie  = "Programmeren"
    Auteur     = "Alice"
    Specificaties = @{
        PaginaAantal = 350
        Formaat      = "A4"
        Taal        = "Nederlands"
    }
}

Write-Host "Nested hashtable voorbeeld:"
Write-Host "PaginaAantal: $($artikelGedetailleerd["Specificaties"]["PaginaAantal"])"
Write-Host "Formaat: $($artikelGedetailleerd.Specificaties.Formaat)"
Write-Host "Taal: $($artikelGedetailleerd.Specificaties.Taal)`n"


