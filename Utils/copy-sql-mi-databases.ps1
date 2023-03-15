$sourceSubscripition = "a9191a1e-480b-42d6-a6ed-c1cc8db25db6"
$targetSubscripition = "043c11c5-65b1-4d04-b8ad-68a92ddfeeac"
$sourceRG = "DDE-Dev-rg"
$targetRG = "DDE-Acc-rg"
$sourceMI = "ddesqldev"

Set-AzContext -SubscriptionId $sourceSubscripition
$result = az sql midb ltr-backup list --resource-group $sourceRG --mi $sourceMI  -l westeurope --database-state Live --only-latest-per-database | ConvertFrom-Json -Depth 50
Set-AzContext -SubscriptionId $targetSubscripition
foreach($item in $result){
    Write-Host "$($item.databaseName) $($item.backupTime.ToString("yyyy-MM-ddTHH:mm:ss"))"
    New-AzResourceGroupDeployment -Name "Deploy_$($item.databaseName)"  `
    -ResourceGroupName $targetRG `
    -Mode Incremental -TemplateParameterFile '/Pipelines/Infrastructure/templates/midatabasesparameters.json' `
    -TemplateFile '/Pipelines/Infrastructure/templates/midatabasesparameters.json' `
    -managedDatabaseName $item.databaseName `
    -restorePointInTime "$($item.backupTime.ToString("yyyy-MM-ddTHH:mm:ss"))" `
    -sourceDatabaseId "/subscriptions/$($sourceSubscripition)/resourceGroups/$($sourceRG)/providers/Microsoft.Sql/managedInstances/$($sourceMI)/databases/$($item.databaseName)"
}