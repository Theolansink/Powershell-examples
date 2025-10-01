# --------------------------------------------
# Function: Get-HighSeverityEvents
# --------------------------------------------
function Get-HighSeverityEvents {
    param(
        # Optioneel: naam van de Event Log, standaard "Security"
        [string]$LogName = "Security",

        # Optioneel: aantal dagen terug om events op te halen, standaard 7
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
    # 🔹 Teruggeven van events als array
    # ============================================
    return $highSeverityEvents
}

# ============================================
# 🔹 Voorbeelden: functie aanroepen
# ============================================

# Ophalen van events in een variabele
$events = Get-HighSeverityEvents -DaysBack 10


# Eventueel door de events loopen en specifieke info tonen
#foreach ($e in $events) {
#    "$($e.TimeCreated) - $($e.Id) - $($e.LevelDisplayName)"
#}