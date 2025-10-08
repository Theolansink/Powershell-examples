# --------------------------------------------
# Function: Get-HighSeverityEvents
# --------------------------------------------
function Get-HighSeverityEvents {
    [CmdletBinding()]  # Maakt -Verbose en andere switches mogelijk
    param(
        [Parameter(Mandatory=$true)]
        [string]$LogName,            # Naam van de Event Log

        [Parameter(Mandatory=$false)]
        [int]$DaysBack = 7           # Aantal dagen terug (standaard 7)
    )

    # ============================================
    # 🔹 Filter instellen voor kritieke en fout-events
    # ============================================
    Write-Verbose "Filter instellen voor high severity events in log '$LogName' van de afgelopen $DaysBack dagen..."

    $filterHash = @{
        LogName   = $LogName
        Level     = 1,2                  # 1 = Critical, 2 = Error
        StartTime = (Get-Date).AddDays(-$DaysBack)
    }

    # ============================================
    # 🔹 Hoge prioriteit events ophalen met foutafhandeling
    # ============================================
    Write-Verbose "Events ophalen uit log '$LogName'..."

    try {
        
        $highSeverityEvents = Get-WinEvent -FilterHashtable $filterHash -MaxEvents 50 -ErrorAction Stop 

        # Check of er events zijn gevonden
        if (-not $highSeverityEvents -or $highSeverityEvents.Count -eq 0) {
            Write-Verbose "Geen high severity events gevonden in log '$LogName'."
            return
        }
    }
    catch [System.Exception] {
        Write-Warning "Fout bij het ophalen van events uit log '$LogName': $_"
        return
    }

    # ============================================
    # 🔹 Events netjes weergeven en doorsturen naar de pipeline
    # ============================================
    Write-Verbose "Totaal gevonden events: $($highSeverityEvents.Count)"

    $highSeverityEvents | ForEach-Object {
        Write-Host "----------------------------------------"
        Write-Host "Time:  $($_.TimeCreated)"
        Write-Host "ID:    $($_.Id)"
        Write-Host "Level: $($_.LevelDisplayName)"
        Write-Host "Message:`n$($_.Message)"
    }
    
}

# ============================================
# 🔹 Voorbeeld: functie aanroepen met verbose
# ============================================
# Events ophalen uit Security log voor de laatste 10 dagen
Get-HighSeverityEvents -LogName "Security" -DaysBack 10 

# Pipelinevoorbeeld: exporteren naar CSV
# Get-HighSeverityEvents -LogName "Security" -DaysBack 10 | Export-Csv -Path "HighSeverityEvents.csv" -NoTypeInformation
