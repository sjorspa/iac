$sourceSubscripition = "bdbdd5c9-0398-4f78-82d2-067432321d78"
$targetSubscripition = "043c11c5-65b1-4d04-b8ad-68a92ddfeeac"
$sourceKV = "DDE-AKV-PROD"
$targetKV = "kv-kpn-dde-dev"

az account set -s $sourceSubscripition


Set-AzContext -SubscriptionId $sourceSubscripition
$result = Get-AzKeyVaultSecret -VaultName DDE-AKV-PROD
foreach($secret in $result){
    $secretName = $secret.Name
    az account set -s $sourceSubscripition
    $secretValue = (Get-AzKeyVaultSecret -Name $secretName -VaultName $sourceKV).SecretValue
    az account set -s $targetSubscripition
    Set-AzKeyVaultSecret -Name $secretName -VaultName $targetKV -SecretValue $secretValue
}

