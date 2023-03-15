#Get-AzSubscription

$storageAccounts = az storage account list | ConvertFrom-Json -Depth 50
$containerArray = @()
foreach($storageAccount in $storageAccounts){
    $containers = az storage container list --account-name $storageAccount.name | ConvertFrom-Json -Depth 50
    foreach($container in $containers){
        $mycontainerObject= [PSCustomObject]@{
            storageName     = $storageAccount.name
            name     = $container.name
            publicAccess     = $container.properties.publicAccess -eq $true
        }
        $containerArray +=$mycontainerObject

    }
}
$containerArray | Export-Csv -Path  c:\temp\containerArray.csv