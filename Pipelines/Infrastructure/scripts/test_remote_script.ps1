az config set extension.use_dynamic_install=yes_without_prompt
$keys = (az storage account keys list -g DDE-Acc-rg -n stkpnddedev) | ConvertFrom-Json
az storage container create -n scripts --account-name stkpnddedev --account-key $keys[0].value
az role assignment create `
    --role "Storage Blob Data Contributor" `
    --assignee 'e5f81be9-71aa-4bd7-a0fd-aadbc178649c' `
    --scope "/subscriptions/043c11c5-65b1-4d04-b8ad-68a92ddfeeac/resourceGroups/DDE-Acc-rg/providers/Microsoft.Storage/storageAccounts/stkpnddedev/blobServices/default/containers/scripts"
#az storage azcopy blob upload -c scripts --account-name stkpnddedev -s 'C:\Projects\DDE-IAC-TMPREPO\Pipelines\Infrastructure\scripts\install_ir_client.ps1' --account-key $keys[0].value
$sastoken = az storage container generate-sas --name scripts --account-name  stkpnddedev --https-only --permissions dlrw --account-key $keys[0].value --expiry '2023-1-1'
$FullUrl = "https://stkpnddedev.blob.core.windows.net/scripts/install_ir_client.ps1?$($sastoken.replace('"',''))"
$folder = "temp"

$command = "New-Item c:\$($folder) -ItemType Directory `n Invoke-WebRequest -Uri '$($FullUrl)' -OutFile c:\$($folder)\install_ir_client.ps1"
Write-Output $command
$result = az vm run-command invoke -g DDE-Acc-rg -n kpnddeadfirdev --command-id RunPowerShellScript --scripts $command
write-host $result