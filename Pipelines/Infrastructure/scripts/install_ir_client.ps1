param(
    [string]$gwPath = "C:\temp\gateway.msi",
    [string]$uri = "https://go.microsoft.com/fwlink/?linkid=839822",
    [string]$authkey
)
    
$date = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
$temppath = "C:\temp"
$testpath = test-path $temppath

if (-not $testpath) {
    mkdir c:\temp
}
$logpath = "c:\temp\ir.log"
$installed = Test-Path -Path 'C:\Program Files\Microsoft Integration Runtime\5.0\Shared\Dmgcmd.exe' -PathType Leaf

If (-Not $installed) {
    Invoke-WebRequest -Uri $uri -OutFile $gwpath
    "${date} downloading gateway.msi`n" | Out-File $logPath -Append
    
    msiexec /i $gwPath /quiet /norestart
    "${date} installing gateway.msi`n" | Out-File $logPath -Append
    
    Start-Sleep -Seconds 180
    
 
} 

   $path = "C:\Program Files\Microsoft Integration Runtime\5.0\Shared"
    cd $path
    .\Dmgcmd.exe -rn $authkey
    .\Dmgcmd.exe -EnableRemoteAccess 80
    .\Dmgcmd.exe -Stop
    .\Dmgcmd.exe -Start