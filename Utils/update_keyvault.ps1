az keyvault update -n keyvaultsjors --enable-soft-delete true 
az keyvault update -n keyvaultsjors --enable-purge-protection true
Update-AzKeyVault -PublicNetworkAccess disabled -VaultName keyvaultsjors -ResourceGroupName monitor
az keyvault set-policy -n keyvaultsjors --object-id 7cd7f0ef-9a00-43c3-bb49-9ffd9ae1d7e8 --secret-permissions set get list
az keyvault update -n keyvaultsjors --enable-purge-protection --bypass AzureServices
az keyvault update -n keyvaultsjors --bypass AzureServices

