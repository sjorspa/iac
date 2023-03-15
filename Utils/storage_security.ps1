#Get-AzSubscription

$storageAcounts = az storage account list | ConvertFrom-Json -Depth 50
$storageAccountArray = @()
foreach($storageAcount in $storageAcounts){
    $myStorageObject= [PSCustomObject]@{
        Name     = $storageAcount.name
        allowBlobPublicAccess     = $storageAcount.allowBlobPublicAccess
        Kind     = $storageAcount.kind
        
        networkRuleSet_defaultAction = $storageAcount.networkRuleSet.defaultAction
        networkRuleSet_networkRuleSet = $storageAcount.networkRuleSet
        
        #virtualNetworkRules = $storageAcount.networkRuleSet.virtualNetworkRules | ConvertTo-Json -Depth 50
        
    }
    $storageAccountArray +=$myStorageObject
}
$storageAccountArray | Export-Csv -Path  c:\temp\security_storage.csv