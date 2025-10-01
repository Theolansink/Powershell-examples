# --------------------------------------------
# PowerShell Script: Loops and select - Get-Process Examples
# --------------------------------------------

# ============================================
# 🔹 Huidige processen ophalen
# ============================================
$processes = Get-Process

# ============================================
# 🔹 FOREACH met array
# ============================================
Write-Host "`n=== FOREACH with array ==="
foreach ($proc in $processes) {
    # Print process name, ID en starttijd
    Write-Host "Process: $($proc.ProcessName), ID: $($proc.Id), $($proc.StartTime)"
}

# ============================================
# 🔹 ForEach-Object (pipeline)
# ============================================
Write-Host "`n=== ForEach-Object (pipeline) ==="
$processes | ForEach-Object {
    Write-Host "Process: $($_.ProcessName), CPU: $($_.CPU)"
}

# ============================================
# 🔹 IF statement
# ============================================
Write-Host "`n=== IF statement ==="
foreach ($proc in $processes) {
    if ($proc.CPU -gt 100) {
        Write-Host "High CPU usage: $($proc.ProcessName) - $($proc.CPU)"
    }
}

# ============================================
# 🔹 SWITCH statement
# ============================================
Write-Host "`n=== SWITCH statement ==="
foreach ($proc in $processes) {
    switch ($proc.ProcessName) {
        "powershell" { Write-Host "This is a PowerShell process: $($proc.Id)" }
        "explorer"   { Write-Host "Explorer process found: $($proc.Id)" }
        default      { } # doe niets voor andere processen
    }
}

# ============================================
# 🔹 WHILE loop
# ============================================
Write-Host "`n=== WHILE loop ==="
$index = 0
while ($index -lt $processes.Count -and $index -lt 5) {
    $proc = $processes[$index]
    Write-Host "WHILE loop process: $($proc.ProcessName), ID: $($proc.Id)"
    $index++
}

# ============================================
# 🔹 DO-WHILE loop
# ============================================
Write-Host "`n=== DO-WHILE loop ==="
$index = 0
do {
    $proc = $processes[$index]
    Write-Host "DO-WHILE loop process: $($proc.ProcessName), ID: $($proc.Id)"
    $index++
} while ($index -lt 5)

# ============================================
# 🔹 BREAK en CONTINUE voorbeeld
# ============================================
Write-Host "`n=== BREAK and CONTINUE example ==="
foreach ($proc in $processes) {
    if ($proc.ProcessName -eq "Idle") { continue }  # sla Idle processen over
    if ($proc.Id -gt 10000) { break }              # stop loop bij groot ID
    Write-Host "Process: $($proc.ProcessName), ID: $($proc.Id)"
}
