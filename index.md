## Oefeningen Powershell scripting

#### Shellscripts en CSV-bestanden:

| Bestandsnaam | Omschrijving|
|--------------|-------------|
|[AD-usernames.csv](./Scripts/AD-usernames.csv)| CSV Bestand met aan te maken accounts |
|[new-bulk-adusers.ps1](./Scripts/new-bulk-adusers.ps1)| Powershellscript voor aanmaken accounts in Active Directory|
|[remove-disabled-accounts.ps1](./Scripts/remove-disabled-accounts.ps1)| Powershellscript voor verwijderen disabled accounts uit AD|
|[new-accounts.csv](./Scripts/new-accounts.csv)| CSV Bestand met gebruikersnamen die nog moeten wordn omgezet naar accountnamen |
|[create-usernames-csvfile.ps1](./Scripts/create-usernames-csvfile.ps1)| Powershellscript om gebruikersnamen om te zetten naar accountnamen|
(|critical-events.ps1 ](./Scripts/critical-events.ps1) | Powershellscript om critical events uit eventlog te tonen |
(|critical-events-param.ps1](./Scripts/critical-events-param.ps1) | toon critical events met gebruik van parameters |

#### Voorbeelden:

| Bestandsnaam | Omschrijving|
|--------------|-------------|
|[string-examples.ps1](./Examples/string-examples.ps1)| Voorbeelden string methoden en operatoren |
|[quote-examples.ps](./Examples/quote-examples.ps1) | Voorbeelden quotes in Powershell |
|[array-examples.ps1](./Examples/array-examples.ps1) | Voorbeelden gebruik array |
|[Date-examples.ps1](./Examples/Date-examples.ps1) | Voorbeelden Date object |
|[Loops-select-examples.ps1](./Examples/Loops-select-examples.ps1) | Voorbeelden Loops en select |
|[critical-events.ps1](./Examples/critical-events.ps1) | Toepassing: Script voor tonen critical events |

#### Functions:

| Bestandsnaam | Omschrijving|
|--------------|-------------|
|[Get-HighSeverityEventsV1.ps1](./Functions/Get-HighSeverityEventsV1.ps1) | Function om high severity security events te tonen |
|[Get-HighSeverityEventsV2.ps1](./Functions/Get-HighSeverityEventsV2.ps1) | Function met parameters om high severity security events te tonen |

#### Modules:

| Bestandsnaam | Omschrijving|
|--------------|-------------|
|[SeverityEvents.psm1](./mymodules/SeverityEvents.psm1) | Module cmdlets om high severity security events te tonen |

#### PSRemoting:

| Bestandsnaam | Omschrijving|
|--------------|-------------|
|[Config-PSremoting-Target.ps1](./PS-remoting/Config-PSremoting-Target.ps1) | Script om PSremoting op target te configureren |
|[config-psremoting-client.ps1](./PS-remoting/config-psremoting-client.ps1) | Script om PSremoting op client te configureren |
|[New-bulk-adusers-winrm.ps1](./PS-remoting/New-bulk-adusers-winrm.ps1) | Script om remote bulk  AD-users toe te voegen |
