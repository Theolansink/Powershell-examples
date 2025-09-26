# Define a sample string
$str = "   Welcome at UMCG   "

Write-Host "Original String: $str"
Write-Host "----------------------------------"

# Trim - remove leading/trailing spaces
$trimmed = $str.Trim()
Write-Host "Trim(): $trimmed"

# ToUpper - convert to uppercase
$upper = $str.ToUpper()
Write-Host "ToUpper(): $upper)"

# ToLower - convert to lowercase
$lower = $str.ToLower()
Write-Host "ToLower(): $lower"

# Substring - take part of the string (notation 1)
$substring = $str.Substring(0, 10)
Write-Host "Substring(0, 10): $substring"

# Substring - take part of the string (notation 2)
Write-Host "Substring(0, 10): $($str.Substring(0, 10))"

# Replace - replace text (method, exact replacement)
$replacedString = $str.Replace('UMCG','Universitair Medisch Centrum Groningen')
Write-Host "Replace('UMCG', 'Universitair Medisch Centrum Groningen'): $($replacedString)"

# replace part of string (operator as +, -, *, -split, -join etc; regex based; not exact string)
$substring = $str -replace('\s[a-zA-Z]+\s', ' ')
Write-host "Middel part string removed: $substring"

# Concat strings
$concat = $str + $substring
Write-host "Concatenated String Str + Middle part string: $concat"

# Contains - check if substring exists
Write-Host "Contains('CG'): $($str.Contains('CG'))"

# StartsWith / EndsWith
Write-Host "StartsWith('Power'): $($trimmed.StartsWith('Power'))"
Write-Host "EndsWith('!'): $($trimmed.EndsWith('!'))"

# IndexOf - find the position of a substring
Write-Host "IndexOf('is'): $($trimmed.IndexOf('is'))"

# Split - break into words
$words = $str.Split(" ")
Write-Host "Split(): $words "
Write-host "Eerste woord: $($words[0])"
Write-host "Tweede woord: $($words[1])"
Write-host "Derde woord: $($words[2])"

# Length - number of characters
Write-Host "Length: $($str.Length)"
