<#
.SYNOPSIS
    Maakt een back-up van bestanden die lange tijd niet geopend zijn.

.DESCRIPTION
    Deze functie maakt een kopie van opgegeven bestanden naar een backupmap als ze
    langer dan het opgegeven aantal dagen niet geopend zijn. Mappen worden overgeslagen.
    De backupmap wordt automatisch aangemaakt als deze nog niet bestaat.

.PARAMETER Bestanden
    Een array van bestanden die gecontroleerd en eventueel geback-upt moeten worden.
    Bestanden kunnen ook via de pipeline worden doorgegeven.

.PARAMETER TijdNietGeopend
    Het aantal dagen dat een bestand niet geopend mag zijn voordat het wordt geback-upt.

.PARAMETER BackupFolder
    Het pad naar de map waarin de back-ups worden opgeslagen. Standaard "D:\backup".

.EXAMPLE
    BackupInactiveFiles -Bestanden "C:\Data\document.txt" -TijdNietGeopend 365

.EXAMPLE
    Get-ChildItem "C:\Data" -Filter "*.txt" | BackupInactiveFiles -TijdNietGeopend 365 -BackupFolder "E:\Backup"
#>
function BackupInactiveFilespipe {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        [string[]]$Bestanden,

        [Parameter(Mandatory = $true)]
        [int]$TijdNietGeopend,

        [string]$BackupFolder = "D:\backup"
    )

    begin {
        if (-not (Test-Path $BackupFolder)) {
            Write-Verbose "Backupmap '$BackupFolder' bestaat niet. Aanmaken..."
            New-Item -Path $BackupFolder -ItemType Directory -Force | Out-Null
        }
        $script:aantalBackups = 0
        $datum = Get-Date -Format "yyyyMMdd_HHmmss"
    }

    process {
        foreach ($bestand in $Bestanden) {
            if (-not (Test-Path $bestand)) {
                Write-Host "Fout: Bestand '$bestand' bestaat niet." -ForegroundColor Red
                continue
            }

            $bestandInfo = Get-Item $bestand
            $laatstGeopend = (Get-Date).AddDays(-$TijdNietGeopend)

            if ($bestandInfo.PSIsContainer) { continue }

            if ($bestandInfo.LastAccessTime -lt $laatstGeopend) {
                $backupBestand = Join-Path $BackupFolder ("{0}_{1}{2}" -f $bestandInfo.BaseName, $datum, $bestandInfo.Extension)

                try {
                    Copy-Item -Path $bestand -Destination $backupBestand -Force
                    $script:aantalBackups++
                    Write-Verbose "Back-up gemaakt van '$bestand' -> '$backupBestand'"
                }
                catch {
                    Write-Host "Fout bij back-up van '$bestand': $_" -ForegroundColor Red
                }
            }
            else {
                Write-Verbose "Bestand '$bestand' is recent geopend. Geen back-up nodig."
            }
        }
    }

    end {
        Write-Host ""
        Write-Host "===============================" -ForegroundColor White
        Write-Host "Totaal aantal bestanden geback-upt: $($script:aantalBackups)" -ForegroundColor Magenta
        Write-Host "===============================" -ForegroundColor White
    }
}
