#############################################################
# Voorbeelden stringmanipulaties
#############################################################

# Definieer een voorbeeld string
$str = "   Welcome at UMCG   "
Write-Host "Originele string: $str"
Write-Host "--------------------------------------------------`n"

# ----------------------------------------------------------
# 🔠 Hoofdletters en kleine letters
# ----------------------------------------------------------
Write-Host "ToUpper(): $($str.ToUpper())"
Write-Host "ToLower(): $($str.ToLower())"
Write-Host "--------------------------------------------------`n"

# ----------------------------------------------------------
# 🔍 Delen van een string pakken
# ----------------------------------------------------------
Write-Host "Substring(0, 10): $($str.Substring(0, 10))"
Write-Host "--------------------------------------------------`n"

# ----------------------------------------------------------
# 🔄 Tekst vervangen
# ----------------------------------------------------------
$replaced = $str.Replace("UMCG","Universitair Medisch Centrum Groningen")
Write-Host "Replace(): $replaced"

$regexReplace = $str -replace('\s[a-zA-Z]+\s', ' ')
Write-Host "Regex Replace (middenwoord weg): $regexReplace"
Write-Host "--------------------------------------------------`n"

# ----------------------------------------------------------
# ➕ Strings samenvoegen
# ----------------------------------------------------------
$concat = $str + " | " + $trimmed
Write-Host "Concatenatie: $concat"
Write-Host "--------------------------------------------------`n"

# ----------------------------------------------------------
# ✂️ Spaties en whitespace verwijderen
# ----------------------------------------------------------
# Let op:
# - Trim() verwijdert ALLE whitespace (spaties, tabs, nieuwe regels)
#   aan BEGIN en EINDE van de string, niet alleen spaties.
# - TrimStart() en TrimEnd() bestaan ook.
#
# Voorbeeldstring met tab en newline:
$whitespaceString = "`t   Welcome at UMCG   `n"
Write-Host "Originele string met tab en newline: [$whitespaceString]"
Write-Host "Lengte voor Trim(): $($whitespaceString.Length)"

$trimmed = $whitespaceString.Trim()
Write-Host "Na Trim(): '[$trimmed]'"
Write-Host "Lengte na Trim(): $($trimmed.Length)"
Write-Host "--------------------------------------------------`n"

# ----------------------------------------------------------
# ❓ Zoeken in een string
# ----------------------------------------------------------
Write-Host "Contains('CG'): $($str.Contains('CG'))"
Write-Host "StartsWith('Welcome'): $($trimmed.StartsWith('Welcome'))"
Write-Host "EndsWith('G'): $($trimmed.EndsWith('G'))"
Write-Host "IndexOf('at'): $($trimmed.IndexOf('at'))"
Write-Host "--------------------------------------------------`n"

# ----------------------------------------------------------
# 🪓 String splitsen in woorden
# ----------------------------------------------------------
$words = $trimmed.Split(" ")
Write-Host "Split(): $words"
Write-Host "Eerste woord: $($words[0])"
Write-Host "Tweede woord: $($words[1])"
Write-Host "Derde woord: $($words[2])"
Write-Host "--------------------------------------------------`n"

# ----------------------------------------------------------
# 🔢 Lengte van de string
# ----------------------------------------------------------
Write-Host "Lengte: $($str.Length)"
Write-Host "--------------------------------------------------`n"

# ----------------------------------------------------------
# 🛡️ Sterke typing (casten naar string)
# ----------------------------------------------------------
[string]$voorbeeld = "dit gaat goed"
Write-Host "Voorbeeld string: $voorbeeld"
Write-Host "--------------------------------------------------`n"
