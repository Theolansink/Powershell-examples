
<#
.SYNOPSIS
    Functie die een back-up maakt van bestanden die lange tijd niet geopend zijn.

.DESCRIPTION
    BackupInactiveFiles controleert opgegeven bestanden en maakt een kopie naar een backupmap
    als ze langer dan het opgegeven aantal dagen niet geopend zijn. Mappen worden overgeslagen.
    De backupmap wordt automatisch aangemaakt als deze nog niet bestaat.

.PARAMETER Bestanden
    Een array van bestanden die gecontroleerd en eventueel geback-upt moeten worden.

.PARAMETER TijdNietGeopend
    Het aantal dagen dat een bestand niet geopend mag zijn voordat het wordt geback-upt.

.PARAMETER BackupFolder
    Het pad naar de map waarin de back-ups worden opgeslagen. Standaard "D:\backup".

.EXAMPLE
    BackupInactiveFiles -Bestanden "C:\Data\document.txt" -TijdNietGeopend 365

.EXAMPLE
    BackupInactiveFiles -Bestanden @("C:\Data\a.txt","C:\Data\b.txt") -TijdNietGeopend 200 -BackupFolder "E:\Backups"
#>
function BackupInactiveFiles {
    param (
        [Parameter(Mandatory = $true)]
        $Bestanden,        # Array van bestanden om te back-uppen

        [Parameter(Mandatory = $true)]
        $TijdNietGeopend,       # Aantal dagen niet geopend

        $BackupFolder = "D:\backup"   # Backupmap
    )

    # Controleer of backupmap bestaat, maak aan indien nodig
    if (-not (Test-Path $BackupFolder)) {
        New-Item -Path $BackupFolder -ItemType Directory -Force | Out-Null
    }

    # Teller voor geback-upte bestanden
    [int]$aantalBackups = 0
    $datum = Get-Date -Format "yyyyMMdd_HHmmss"

    # Doorloop elk bestand
    foreach ($bestand in $Bestanden) {

        if (-not (Test-Path $bestand)) {
            Write-Host "Fout: Bestand '$bestand' bestaat niet." -ForegroundColor Red
            continue
        }

        $bestandInfo = Get-Item $bestand
        $laatstGeopend = (Get-Date).AddDays(-$TijdNietGeopend)

        # Skip directories
        if ($bestandInfo.PSIsContainer) { continue }

        # Controleer of bestand ouder is dan opgegeven tijd
        if ($bestandInfo.LastAccessTime -lt $laatstGeopend) {

            $backupBestand = Join-Path $BackupFolder ("{0}_{1}{2}" -f $bestandInfo.BaseName, $datum, $bestandInfo.Extension)

            try {
                Copy-Item -Path $bestand -Destination $backupBestand -Force
                $aantalBackups++
                Write-Host "Back-up gemaakt van '$bestand' -> '$backupBestand'"
            }
            catch {
                Write-Host "Fout bij back-up van '$bestand': $_" -ForegroundColor Red
            }
        }
    }

    # Toon totaalresultaat
    Write-Host ""
    Write-Host "===============================" -ForegroundColor White
    Write-Host "Totaal aantal bestanden geback-upt: $($aantalBackups)" -ForegroundColor Magenta
    Write-Host "===============================" -ForegroundColor White
}
