# --------------------------------------------
# Script: High Severity Security Events
# --------------------------------------------

param(
    # Naam van de Event Log (standaard "Security")
    [Parameter(Position=0, Mandatory= $false)]
    [ValidateScript({
        if (-not $_) {
            throw "De parameter 'LogName' mag niet leeg zijn. Geef een lognaam op (bijv. 'Security' of 'Application')."
        }
        return $true
    })]
    [string]$LogName = "Security" ,

    # Aantal dagen terug om events op te halen (standaard 7)
    [int]$DaysBack = 7
)

# ============================================
# 🔹 Filter instellen voor kritieke en fout-events
# ============================================
$filterHash = @{
    LogName   = $LogName
    Level     = 1,2                  # 1 = Critical, 2 = Error
    StartTime = (Get-Date).AddDays(-$DaysBack)
}

# ============================================
# 🔹 Hoge prioriteit events ophalen
# ============================================
$highSeverityEvents = Get-WinEvent -FilterHashtable $filterHash -MaxEvents 50

# ============================================
# 🔹 Events weergeven
# ============================================
$highSeverityEvents | ForEach-Object {
    Write-Host "----------------------------------------"
    Write-Host "Time: $($_.TimeCreated)"
    Write-Host "ID: $($_.Id)"
    Write-Host "Level: $($_.LevelDisplayName)"
    Write-Host "Message: $($_.Message)"
}
