$WCC = get-scomclass -name "Microsoft.SystemCenter.Agent"
$MO = Get-SCOMMonitoringObject -class:$WCC | where {$_.IsAvailable –eq $false}
#$MO | select DisplayName | ft -hidetableheaders |  Out-File -filepath D:\Scripts\GreyAgents.txt
$MO |Select-Object -ExpandProperty DisplayName | ft -hidetableheaders | Out-File -filepath D:\Scripts\GreyAgents.txt

