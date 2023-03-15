# Technical Document IAC / Devops Pipelines

## Description

This document describes the technical details about our new IAC setup, Environments, Sizing's  and general best practices.

## General considerations and best Practices

 - We practice the principle of IAC, which will mean that all our resources are defined in code and can be deployed via Devops Pipelines, if we can not deploy and or configure resources automatically the process needs to be documented at all times.
 - Concerning security we apply the [Principle of least privilege](https://en.wikipedia.org/wiki/Principle_of_least_privilege)
 - When choosing an Azure solution we always go for SaaS over PaaS over IaaS, this means  that we always try to choose a solution which keeps the manageable cost as los as possible, and keeping us as close as possible to the native platform.
 - From a security principle we try to apply authorization in the following order:
	 - Authorization using a Managed Identity
	 - A connectionstring or key stored in a Keyvault
	 - Sas or PAT tokens, in case of SAS tokens try to avoid anonymous access, PAT tokens are not desirable but sometimes needed, IE in the case of Azure Devops
- Connectivity
	- We try to keep our resources isolated in a Virtual Network
	- When possible make use of the KPN Connectivity, ie Express Route or Stepping Stone Machines
	- Avoid IP Whitelisting for home connectivity, especially when AD Authentication is not possible
	- It should be prevented that (sensitive) production data leaves the barriers of the environment, when needed decide or there should be an anonymization process. When in doubt make an risk assesment and discuss with your teamlead or manager.
- Since we make use of IAC it is important to implement the 4 eyes principle, no IAC code should be released to production environment by a single person, Azure Devops can prevent this by setting Environment barriers.
- There should be a basic plan for (data) recovery and or takeout in the case of a major outage or global event. (IE a economic sanction).

### Naming conventions
In general we follow the naming conventions advised by Microsoft see: [Abbreviations](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-abbreviations) and [Best Practices](https://learn.microsoft.com/en-us/azure/cloud-adoption-framework/ready/azure-best-practices/resource-naming) .

Looking at our current enviroments, I will propose the following names:

|Resource|Abbreviation  | Namespace
|--|--|--|
|Resource Group|rg|Microsoft.Resources/resourceGroups
|App Service Plan|asp| Microsoft.Web/serverFarms
|Application Insights|appi| Microsoft.Insights/components
|Azure Data Factory|adf| Microsoft.DataFactory/factories
|Managed disk (OS)|disk| Microsoft.Compute/disks
|Function app|func|Microsoft.Web/sites`
|App Service Plan|asp| Microsoft.Web/serverFarms
|Key vault|kv|Microsoft.KeyVault/vaults
|Log Analytics workspace|log|Microsoft.OperationalInsights/workspaces
|SQL Managed Instance|sqlmi|Microsoft.Sql/managedInstances
|Private endpoint|pep|Microsoft.Network/privateEndpoints
|Network interface (NIC)|ni|Microsoft.Network/networkInterfaces
|Recovery Services vault|rsv|Microsoft.RecoveryServices/vaults
|Storage account|st|Microsoft.Storage/storageAccounts
|Virtual machine|vm|Microsoft.Compute/virtualMachines

## Enviroments and resources
|                         | Desired Name                  | Current Resource                           | Current SKU / Sizing       | IAC Implemented | Hardened / Ideal state | Keep   | Keep   |   |
|-------------------------|-------------------------------|--------------------------------------------|----------------------------|-----------------|------------------------|--------|--------|---|
| Log Analytics Workspace | log-kpn-dde-prd               | ddeloganalyticsprod                        | Pay-as-you-go              | Partially       | No                     | Yes    | ------ |   |
| Virtual Network         | vnet-kpn-dde-dev              | d.n.a                                      | d.n.a                      | Partially       | Partially              | Yes    | Yes    |   |
| Application Insights    | Decide                        | appinsights-dde-feedbackloopprd            | d.n.a                      | d.n.a           | d.n.a                  | Decide | Decide |   |
|                         | Decide                        | DDE-AzureFunctions-ADFManager-Prd          | d.n.a                      | d.n.a           | d.n.a                  | Decide | Decide |   |
|                         | Decide                        | ddeazfspbirefreshprd                       | d.n.a                      | d.n.a           | d.n.a                  | Decide | Decide |   |
| Keyvault                | kv-kpn-dde-prd                | DDE-AKV-PROD                               | Standard                   | No              | No                     | Yes    | Decide |   |
| Storage Account         | Decide                        | blobfeedbackloopprd                        | Standard                   | Partially       | No                     | Decide | Decide |   |
|                         | Decide                        | ddeazfpbirefreshprd                        | Standard                   | Partially       | No                     | Decide | Decide |   |
|                         | stgkpnddedatalakeprd          | ddedatalakeprod                            | Standard                   | Partially       | No                     | Yes    | Yes    |   |
|                         | Decide                        | ddeloggingprod                             | Standard                   | Partially       | No                     | Decide | Yes    |   |
|                         | Decide                        | ddeprodrga015                              | Standard                   | Partially       | No                     | Decide | Yes    |   |
|                         | Decide                        | ddeprodrgbcb3                              | Standard                   | Partially       | No                     | Decide | Yes    |   |
| Function Plan           | asp-kpn-dde-functions-dev     | ASP-DDE-PRD                                | S1                         | No              | d.n.a                  | Yes    | Yes    |   |
|                         | d.n.a                         | ASP-DDE-AzureFunctions-PbiRefresh-Prd-518c | Y1 (dynamic                | d.n.a           | d.n.a                  | Decide | Yes    |   |
| Function App            | func-kpn-dde-azfcollector-prd | dde-azf-collector-prd                      | S1 (shared ASP-DDE-PRD)    | No              | No                     | Yes    | Decide |   |
|                         | func-kpn-dde-adfmanager-prd   | DDE-AzureFunctions-ADFManager-Prd          | S1 (shared ASP-DDE-PRD)    | No              | No                     | Yes    | Decide |   |
|                         | func-kpn-dde-feedbackloop-prd | DDE-AzureFunctions-FeedbackLoopPrd         | S1 (shared ASP-DDE-PRD)    | No              | No                     | Yes    | Yes    |   |
|                         | func-kpn-dde-pbirefresh-prd   | DDE-AzureFunctions-PbiRefresh-Prd          | S1 (shared ASP-DDE-PRD)    | No              | No                     | Yes    | Decide |   |
| Recovery Service Vault  | rsv-kpn-dde-prd               | vault531                                   | d.n.a                      | No              | No                     | Decide | Decide |   |
| SQL Managed Instance    | sqlmi-kpn-dde-prd             | ddesqlprod                                 | Standard-series (Gen 5) 4C | No              | No                     | Yes    | Yes    |   |
| Virtual Machine         | VM-SHIR-PRD-001               | ADF-SHIR-PRD-001                           | Standard D8s v3            | No              | No                     | Decide | Decide |   |
|                         | Decide                        | az-ddeprodsha                              | Standard DS1 v2            | No              | No                     | Decide | Decide |   |
| Data Factory            | ADF-KPN-DDE-PRD               | DDE-ADF-PRD                                | d.n.a                      | No              | No                     | Decide | Decide |   |
|                         | t.b.d.                        | DDE-ADF-SH-RUNTIMES-PRD                    | d.n.a                      | No              | No                     | Decide | Decide |   |
| Private Endpoint        | pep-kpn-dde-prd               | DDE-ADF-PE                                 | d.n.a                      | No              | No                     | Decide | Decide |   |

