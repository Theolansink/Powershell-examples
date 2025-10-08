# --------------------------------------------
# Function: Get-HighSeverityEvents
# --------------------------------------------
function Get-HighSeverityEvents {
    param(
        # Optioneel: naam van de Event Log, standaard "Security"
        [string]$LogName = "Security",

        # Optioneel: aantal dagen terug om events op te halen, standaard 7
        [int]$DaysBack = 7,

        # file voor output
        $outfile = "D:\Powershell\highsecurityevents-$(Get-Date -Format "yyyy-MM-dd")"
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
    try{
        $highSeverityEvents = Get-WinEvent -FilterHashtable $filterHash -MaxEvents 50 -ErrorAction Stop
    }
    catch {
        $highSeverityEvents = "Get-winevent geeft geen events van type $logname, loglevel 1 en 2 over de afgelopen $daysback dagen gevonden"
        $highSeverityEvents | out-file $outfile
        return $highSeverityEvents
    }
    # ============================================
    # 🔹 Teruggeven van events als array
    # ============================================
    $highSeverityEvents | out-file $outfile -Force
    return $highSeverityEvents    
}

# ============================================
# 🔹 Voorbeelden: functie aanroepen
# ============================================

# Ophalen van events in een variabele
$events = Get-HighSeverityEvents -DaysBack 10