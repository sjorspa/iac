# KPN DDE Impediments and Roadmap

## [x] Phase 1 getting Ready

### Azure Resources Creation & Dependencies

- [x] Create Temporary Git Repo on new Organization
- [maybelater] Get new Azure Subscription(s)
- [x] Use existing Azure Subscription / Resource Group: [DDE-Acc-rg](https://portal.azure.com/#@kpnbv.onmicrosoft.com/resource/subscriptions/043c11c5-65b1-4d04-b8ad-68a92ddfeeac/resourceGroups/DDE-Acc-rg/overview)
- [x] Get new Deployment Service Principals for Azure Devops: KPN-DDEDEPLOY-READWRITE-ACC
- [ ] Onder /RequiredAccessRights lijst met gewenste authorisaties (ideaalplaatje) op subscription, resource group
- [ ] Service Principal has access to azure resources (opvragen bij DCloud/Noëlle)

### Required Access Rights

#### Azure Subscription

- [ ]

Benodigde changes om te komen tot gewenste situatie:

#### Access Requirements for each developer

- [x] Get Access to Documentation Project;
- [.] All developers that need access have access;

## Phase 2: MvP Deploy Configuration Initialization

- [x] IAC: Assess setup of MVP of Infrastructure Pipeline with a minimal resource (IE Resourcegroup with storage account)
- [ ] IAC: Decide final Environments and Trigger strategy
- [ ] IAC: Decide naming convections (based on KPN best practices if available)
- [x] IAC: Create script to get current configuration and resources, discussed with Mathijs that there is currently a mechanism to retrieve this.
- [ ] Research order of creating resources (IE first Network before storage account)



## Phase 3

Implement for each Resource a step in the pipeline and:

- IAC: Store configuration of resource in a Text file
- IAC: Implement Resource in Pipeline
- IAC: Update documentation on how this resource was added, and describe sizing per Environment
- IAC: Validate configuration with KPN Infrastructure department

## Phase 4

- [ ] IAC: Assessment on how and which resources should be migrated
- [ ] IAC: Timeframe when and how we migrate
- [ ] IAC: Review Backup/Restore process
- [ ] IAC: Migrate existing non Infrastructure pipelines to new organization and Infrastructure

### Assessment on how and which resources should be migrated
#### Azure Resource Group

- [ ] Huidige sitatie DEV/PRD: Principal is 'KPN Application Contributor'  
  (KPN Application Contributor: Lets you manage everything except access to Network resources and user management.)
- [ ] Gewenste situatie:
  - [ ] Ik als DataOps engineer ben KPN Application Contributor
  - [  ] Data Engineer is KPN Contributor op SQLMI
  - [ ] xyz is op xyz
## IAC Phase 5 Platform Maturity

- [ ] IAC: Mature Pipelines, IE security/dependency checks and or Code Quality Inspection
- [ ] IAC: Integrate Unit and or Integration in Pipelines
- [ ] IAC: Strategy on keeping Templates UpToDate and or Pull into KPN Docs Repository
- [ ] IAC: Pentest on environment (might be useful after or just before migration)

## Week Planning

|Week|Actions|
|--|--|
| 41  10-10 / 16-10 |Finish Requirements like connectivity, Repo and test of first deployment of most basic pipeline and enviroment file
| 42  17-10 / 23-10| Setting up Enviroments Trigger Strategy, Final Setup of Repository, Decide about secrets and settings, in short: Everything is setup to add the individual compononents. Document Network Overview
| 43 24-10 / 30-10| First part of components:  - Storage Accounts (/blob store), Key Vault, Azure Data Factory, SQL Managed Instance, Azure SQL Databases (/managed)
| 44 31-10 / 06-11 |Second Part of Components: Azure Function Apps, App Service Plans(s), Virtual Machines, Network Interfaces, Data Disks oor VM's)
| 45 07-11 / 13-11 | Slack for fixing impedements
| 46 14-11 / 20-11 | Migrate/Plan existing pipeleines and data to new enviroment
| 47 21-11 / 27-11 | Migrate/Plan existing pipeleines and data to new enviroment
| 48 28-11 / 04-12| Acceptance Testing by Team
|
