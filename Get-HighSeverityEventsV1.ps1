# --------------------------------------------
# Function: Get-HighSeverityEvents
# --------------------------------------------
function Get-HighSeverityEvents {
    param(
        [Parameter(Mandatory=$true)]
        [string]$LogName,            # Naam van de Event Log

        [Parameter(Mandatory=$false)]
        [int]$DaysBack = 7           # Aantal dagen terug (standaard 7)
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
    # 🔹 Events netjes weergeven
    # ============================================
    if ($highSeverityEvents.Count -eq 0) {
        Write-Host "Geen high severity events gevonden in $LogName voor de afgelopen $DaysBack dagen."
        return
    }

    Write-Host "`nDisplaying high severity security events from $LogName (last $DaysBack days):`n"
    $highSeverityEvents | ForEach-Object {
        Write-Host "----------------------------------------"
        Write-Host "Time:  $($_.TimeCreated)"
        Write-Host "ID:    $($_.Id)"
        Write-Host "Level: $($_.LevelDisplayName)"
        Write-Host "Message:`n$($_.Message)"
    }
}

# ============================================
# 🔹 Voorbeeld: functie aanroepen
# ============================================
# Haal high severity events op uit Security log voor de laatste 7 dagen
Get-HighSeverityEvents -LogName "Security" -DaysBack 10

# Haal high severity events op uit System log voor de laatste 3 dagen
#Get-HighSeverityEvents -LogName "System" -DaysBack 3
