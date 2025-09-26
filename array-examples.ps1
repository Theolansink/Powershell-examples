# get-process-arrays-demo.ps1
# Demo: Working with arrays created by Get-Process

Write-Host "=== Get-Process Array Demo ===" -ForegroundColor Cyan

# Get all running processes (creates an array)
$processes = Get-Process
Write-Host "Number of processes: $($processes.Count)"
Write-Host "Type of array: $($processes.GetType().Name)"
Write-Host ""

Write-Host "=== Accessing Elements ===" -ForegroundColor Cyan
Write-Host "First process name: $($processes[0].Name)"
Write-Host "Last process name: $($processes[-1].Name)"
Write-Host "Subarray of first 5 processes:"
$processes[0..4] | ForEach-Object { Write-Host "  $_.Name" }
Write-Host ""

Write-Host "=== Iterating Over Processes ===" -ForegroundColor Cyan
foreach ($proc in $processes[0..4]) {
    Write-Host "Process: $($proc.Name), ID: $($proc.Id), CPU: $($proc.CPU)"
}
Write-Host ""

Write-Host "=== Array Methods and Operators ===" -ForegroundColor Cyan
# Sort by process name
$sorted = $processes | Sort-Object Name
Write-Host "First 5 sorted process names:"
$sorted[0..4] | ForEach-Object { Write-Host "  $_.Name" }

# Filter using -contains or Where-Object
$notepad = $processes | Where-Object { $_.Name -eq "notepad" }
Write-Host ""
Write-Host "Notepad processes found: $($notepad.Count)"
Write-Host ""

Write-Host "=== Join Process Names Into a String ===" -ForegroundColor Cyan
$names = ($processes[0..4].Name) -join ", "
Write-Host "First 5 process names joined: $names"
Write-Host ""

Write-Host "=== End of Demo ===" -ForegroundColor Green
