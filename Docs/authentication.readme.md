# Authentication Principles

## Service Principal Guidelines

Ideally we'd have a service principal per 'DDE app'

Right now we have three:

- DDE-DEPLOY-DEV
- DDE-DEPLOY-PRD
- DDE-DEPLOY-SHAREPO-PRD

## Accounts & Service Principals

### Service Principal

#### Where is it stored?

- Keyvault Endpoint
  - dev
  - prd
- Keyvault Secrets
  - :Application ID's:
  - :Secret are stored in their respective keyvault

#### Where is it used?

Local Scripts/Modules

- PbixBuildDeploy Agent
- RefreshJiraAgent
- XlsxManager

Azure Functions

- PbixRefresher
- DataFeedbackLoop
- DDE Collector (/under construction)

Azure Infra Other

- Azure Devops Service Connection

### Virtueel Persoon

A 'virtueel persoon' is a KPN workplace account that can be used to authenticate to services that require IAM access and do not work with Service Principals.

### Where is it stored?

Virtueel Persoon (DDE-VIPER)

- Service Principal Username & Password are saved in the dev/prd keyvault

### Where is it used?

- RefreshJiraAllPlatforms.ps1
