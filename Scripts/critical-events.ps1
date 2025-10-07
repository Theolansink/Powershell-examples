# --------------------------------------------
# Example: High Severity Security Events
# --------------------------------------------

# Define the Event Log and filter for Security events for last 7 days
$logName = "Security"

# Define filter hash table for Get-WinEvent; critical events and errors from last 7 days.
$filterHash = @{
    LogName   = $logName
    Level     = 1,2  # 1 = Critical, 2 = Error
    StartTime = (Get-Date).AddDays(-7)
}

# Get high severity security events


# Display the events
$highSeverityEvents | ForEach-Object {
    Write-Host "----------------------------------------"
    Write-Host "Time: $($_.TimeCreated)"
    Write-Host "ID: $($_.Id)"
    Write-Host "Level: $($_.LevelDisplayName)"
    Write-Host "Message: $($_.Message)"
}



