# Opzet KPN DDE IAC

## Doelstelling

Als KPN DDE Team willen we in principe al onze resources volledig onder controle hebben door middel van borging in code (IAC). Daarnaast willen we borgen dat onze volledige configuratie geborgd is in code zodat we ook op dit gebied alle wijzigingen onder versie beheer hebben.
Daarnaast dienen deze resources volledig uitgerold te kunnen worden middels Azure DevOps pipelines.

## Aannames

- We sluiten zoveel mogelijk aan op de gangbare best practices binnen KPN qua security en configuratie
- Onze Infrastructure pipeline is qua werking voor alle omgevingen gelijk, echter per omgeving kunnen we geparametriseerd besluiten zaken als security toegang, instance model, etc. te beslissen
- Qua networking sluiten we aan op bestaande situaties, het creeren van network resoucres zoals VNets, Firewalling, Subnets kan in overleg buiten de scope van het DDE team vallen, het zelfde geld voor zaken als audit logging en of het toepassen van KPN brede Azurep policies

## Actiepunten

- [ ] Sjors zal een opzet maken van een basis pipeline om bijvoorbeeld 1 simpele Resource te genereren (bijvoorbeeld een resourcegroup of een storage account
- [ ] We moeten aan de hand van de huidige omgevingen een volledige inventarisatie maken van in gebruik zijnde componenten, en hoe deze componenten geconfigureerd zijn qua: connectivity, access control en sizing.
  Het gaat om de volgende componenten:

## Initiele Inventarisatie Relevante Resources

### Must-haves

- Key Vault
- Storage Accounts (/blob store)
- Azure Functions (Apps)
- App Service Plans(s)
- Virtual Machines
  - Network Interfaces
  - Data Disks (voor VM's)
- Azure Data Factory
- SQL Managed Instance
  - Azure SQL Databases (/managed)

### Nice-to-have

- Applicaton Insights / Log Analytics Workspace
- Automation Account MV:
  - legacy, kan weg

### To depricate

- Runbook
- Azure SQL db

### Priority tbd

- Private Endpoints
- Data collection rule
- [ ] Per omgeving dienen we in Azure Devops een deployment user te hebben (eventueel gehared, bijvoorbeeld 1 user voor dev/test, en  1 voor acc/prd
- [ ] Afspraken met betrekking tot naming conventions (eventueel checken of we hier al een standaard voor hebben binnen KPN)
- [ ] Migratieplan maken hoe we overgaan van huidige omgeving, naar nieuwe omgeving

## Inventarisatie toepasbaarheid van KPN documentatie

[kpn-documentation-deepdive.md](kpn-documentation-deepdive.md)
