#Get-AzSubscription

$keyVaults = az keyvault list | ConvertFrom-Json -Depth 50
$keyVaultsArray = @()
foreach($keyVault in $keyVaults){
    $keyVaultDetailed = az keyvault show --name $keyVault.name | ConvertFrom-Json -Depth 50
    $myKeyVaultObject= [PSCustomObject]@{
        name     = $keyVaultDetailed.name
        enablePurgeProtection     = $keyVaultDetailed.properties.enablePurgeProtection
        enableSoftDelete     = $keyVaultDetailed.properties.enableSoftDelete
        softDeleteRetentionInDays     = $keyVaultDetailed.properties.softDeleteRetentionInDays
        sku     = $keyVaultDetailed.properties.sku.name
    }
    $keyVaultsArray +=$myKeyVaultObject
}
$keyVaultsArray | Export-Csv -Path  c:\temp\security_keyvault.csv