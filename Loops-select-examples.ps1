# --------------------------------------------
# Loops and select: Get-Process Examples
# --------------------------------------------

# Get current processes
$processes = Get-Process

Write-Host "`n=== FOREACH with array ==="
foreach ($proc in $processes) {
    # Print process name and ID
    Write-Host "Process: $($proc.ProcessName), ID: $($proc.Id), $($proc.StartTime)"
}

Write-Host "`n=== ForEach-Object (pipeline) ==="
$processes | ForEach-Object {
    Write-Host "Process: $($_.ProcessName), CPU: $($_.CPU)"
}

Write-Host "`n=== IF statement ==="
foreach ($proc in $processes) {
    if ($proc.CPU -gt 100) {
        Write-Host "High CPU usage: $($proc.ProcessName) - $($proc.CPU)"
    }
}

Write-Host "`n=== SWITCH statement ==="
foreach ($proc in $processes) {
    switch ($proc.ProcessName) {
        "powershell" { Write-Host "This is a PowerShell process: $($proc.Id)" }
        "explorer"   { Write-Host "Explorer process found: $($proc.Id)" }
        default      { } # do nothing for other processes
    }
}

Write-Host "`n=== WHILE loop ==="
$index = 0
while ($index -lt $processes.Count -and $index -lt 5) {
    $proc = $processes[$index]
    Write-Host "WHILE loop process: $($proc.ProcessName), ID: $($proc.Id)"
    $index++
}

Write-Host "`n=== DO-WHILE loop ==="
$index = 0
do {
    $proc = $processes[$index]
    Write-Host "DO-WHILE loop process: $($proc.ProcessName), ID: $($proc.Id)"
    $index++
} while ($index -lt 5)

Write-Host "`n=== BREAK and CONTINUE example ==="
foreach ($proc in $processes) {
    if ($proc.ProcessName -eq "Idle") { continue }  # skip Idle processes
    if ($proc.Id -gt 10000) { break }              # stop loop on large ID
    Write-Host "Process: $($proc.ProcessName), ID: $($proc.Id)"
}
