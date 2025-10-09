## Oefeningen Powershell scripting

#### Link naar labs Microsoft AZ040:  
[AZ040 Powershell labs ]( https://microsoftlearning.github.io/AZ-040T00-Automating-Administration-with-PowerShell/)

#### Shellscripts en CSV-bestanden:

| Bestandsnaam | Omschrijving|
|--------------|-------------|
|[AD-usernames.csv](./Scripts/AD-usernames.csv)| CSV Bestand met aan te maken accounts |
|[new-bulk-adusers.ps1](./Scripts/new-bulk-adusers.ps1)| Powershellscript voor aanmaken accounts in Active Directory|
|[remove-disabled-accounts.ps1](./Scripts/remove-disabled-accounts.ps1)| Powershellscript voor verwijderen disabled accounts uit AD|
|[new-accounts.csv](./Scripts/new-accounts.csv)| CSV Bestand met gebruikersnamen die nog moeten wordn omgezet naar accountnamen |
|[create-usernames-csvfile.ps1](./Scripts/create-usernames-csvfile.ps1)| Powershellscript om gebruikersnamen om te zetten naar accountnamen|
|[critical-events.ps1 ](./Scripts/critical-events.ps1) | Powershellscript om critical events uit eventlog te tonen |
|[critical-events-param.ps1](./Scripts/critical-events-param.ps1) | toon critical events met gebruik van parameters |

#### Voorbeelden:

| Bestandsnaam | Omschrijving|
|--------------|-------------|
|[find-cmdlets-examples.ps1](./Examples/find-cmdlets-examples.ps1)| Voorbeelden: Hoe vindt je cmdlets en informatie daarover |
|[pipeline.ps1](./Examples/pipeline.ps1)| Voorbeelden van cmdlets in de pipeline |
|[string-examples.ps1](./Examples/string-examples.ps1)| Voorbeelden string methoden en operatoren |
|[quote-examples.ps](./Examples/quote-examples.ps1) | Voorbeelden quotes in Powershell |
|[array-examples.ps1](./Examples/array-examples.ps1) | Voorbeelden gebruik array |
|[hashtable-examples.ps1](./Examples/hashtable-examples.ps1) | Voorbeelden gebruik hashtable |
|[Date-examples.ps1](./Examples/Date-examples.ps1) | Voorbeelden Date object |
|[Loops-select-examples.ps1](./Examples/Loops-select-examples.ps1) | Voorbeelden Loops en select |
|[new-bulk-adusers-hash-param.ps1](./Examples/new-bulk-adusers-hash-param.ps1)| Script voor aanmaken accounts in AD met hashtable en parameter|
|[critical-events.ps1](./Scripts/critical-events.ps1) | Toepassing: Script voor tonen critical events |

#### Functions:

| Bestandsnaam | Omschrijving|
|--------------|-------------|
|[Get-HighSeverityEventsV1.ps1](./Functions/Get-HighSeverityEventsV1.ps1) | Function om high severity security events te tonen |
|[Get-HighSeverityEventsV2.ps1](./Functions/Get-HighSeverityEventsV2.ps1) | Function met parameters om high severity security events te tonen |
|[new-bulk-adusers-function.ps1](./Functions/new-bulk-adusers-function.ps1) | Aanmaken accounts in AD als functie |

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

#### Scheduled Tasks

| Bestandsnaam | Omschrijving|
|--------------|-------------|
|[create-scheduled-task.ps1](./ScheduledTask/create-scheduled-task.ps1) | Script om scheduled task te configureren |
|[get-highsecurityeventsdaily.ps1](./ScheduledTask/get-highsecurityeventsdaily.ps1) | Script om high security events dagelijks in bestand oip te slaan. |
|[get-highsecurityeventsdailyjob.ps1](./ScheduledTask/get-highsecurityeventsdailyjob.ps1) | Script om scheduled job te configureren (Deprecated: niet in Powershell 7)|
