# -------------------------------------------------------------------------------
# Cmdlet: Get-HighSeverityEvents  
# In module SeverityEvents.psm1
# Module moet geimporteerd worden: import-module "<sub-path>.SeverityEvents.psm1"
# Import kan gedaan worden in $profile.
# -------------------------------------------------------------------------------
function Get-HighSeverityEvents {
    [CmdletBinding()]
    param(
        # Optioneel: naam van de Event Log, standaard "Security"
        [ValidateNotNullOrEmpty()]
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

function Get-HighSeverityEventsPipe {
    [CmdletBinding()]
    param(
        # LogName kan uit pipeline of via parameter worden meegegeven
        [Parameter(Mandatory=$false, ValueFromPipeline=$true)]
        [ValidateNotNullOrEmpty()]
        [string]$LogName = "Security",

        # Aantal dagen terug om events op te halen
        [Parameter(Mandatory=$false)]
        [ValidateRange(1,365)]
        [int]$DaysBack = 7
    )

    process {
        # Filter voor kritieke en fout-events
        $filterHash = @{
            LogName   = $LogName
            Level     = 1,2
            StartTime = (Get-Date).AddDays(-$DaysBack)
        }

        # Hoge prioriteit events ophalen en teruggeven
        $HighSeverityEvents = Get-WinEvent -FilterHashtable $filterHash -MaxEvents 50
        $HighSeverityEvents  # geen returnm gebruikt want dan stopt pipe als bv "application","security"worden meegegeven
    }
}
