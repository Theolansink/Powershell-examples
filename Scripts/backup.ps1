<#
.SYNOPSIS
    Maakt een back-up van bestanden die langer dan een opgegeven tijd niet geopend zijn.

.DESCRIPTION
    Dit script maakt een kopie van opgegeven bestanden naar een backupmap als ze de 
    opgegeven periode niet geopend zijn. Mappen worden overgeslagen. De backupmap 
    wordt automatisch aangemaakt als deze nog niet bestaat.

.PARAMETER Bestanden
    Een of meerdere bestanden die gecontroleerd en eventueel geback-upt moeten worden.
    Kan een enkele string of een array van strings zijn.

.PARAMETER TijdNietGeopend
    Het aantal dagen dat een bestand niet geopend mag zijn voordat het wordt geback-upt.

.PARAMETER BackupFolder
    Het pad naar de map waarin de back-ups worden opgeslagen. Standaard "D:\backup".

.EXAMPLE
    .\BackupBestanden.ps1 -Bestanden "C:\Data\document.txt" -TijdNietGeopend 365

.EXAMPLE
    .\BackupBestanden.ps1 -Bestanden @("C:\Data\a.txt","C:\Data\b.txt") -TijdNietGeopend 200 -BackupFolder "E:\Backups"
#>


param (
    [Parameter(Mandatory = $true, Position = 0)]
    $Bestanden,      # Eventueel te backuppen bestanden
    [Parameter(Mandatory = $true, Position = 1)]
    $TijdNietGeopend,

    $BackupFolder = "D:\backup"
)

# Controleer of backupmap bestaat
if ( !(Test-Path $BackupFolder)) {
    new-item -Path $backupfolder -ItemType Directory
}


# Tel aantal gemaakte back-ups
[int]$aantalbackups = 0
$datum = Get-Date -Format "yyyyMMdd_HHmmss"

# Doorloop elk bestand
foreach ($bestand in $Bestanden) {
        if ( !(Test-Path $bestand)) {
            Write-Host "Fout: Bestand '$bestand' bestaat niet." -ForegroundColor Red
            continue
        }

        $bestandInfo = Get-Item $bestand
        $laatstGeopend = (Get-Date).AddDays(-$TijdNietGeopend)

        if ($bestandinfo.PSIsContainer) {
            continue
        }
        if ($bestandInfo.LastAccessTime -lt $laatstGeopend) {

            $backupBestand = $BackupFolder + "\"+ $bestandInfo.BaseName + $datum + $bestandInfo.Extension

            try {
                Copy-Item -Path $bestand -Destination $backupBestand -Force
                $aantalbackups++
                write-verbose "Backup van bestand $bestand is gemaakt"
            }
            catch {
                Write-Host " Fout bij back-up van '$bestand': $_" -ForegroundColor Red
            }
        }
        
    }

    # Toon totaalresultaat
    Write-Host ""
    Write-Host "===============================" -ForegroundColor White
    Write-Host "Totaal aantal bestanden geback-upt: $($aantalbackups)" -ForegroundColor Magenta
    Write-Host "===============================" -ForegroundColor White
