Import-Module SSH-Sessions
New-SshSession -ComputerName 10.254.216.213 -Username "S0184551-A" -Password "abcd1234"
echo "=================================================================================================="
$SshSessions.'10.254.216.213'.Runcommand('hostname').Result
echo "=================================================================================================="
echo "=================================================================================================="
echo "						DATA DOMAIN ALERTS					"
echo "=================================================================================================="
$SshSessions.'10.254.216.213'.Runcommand('alerts show current').Result
echo "=================================================================================================="
echo "					DATA DOMAIN FILESYSTEM STATUS					"
echo "=================================================================================================="
$SshSessions.'10.254.216.213'.Runcommand('df').Result
echo "=================================================================================================="
echo "					DATA DOMAIN FILESYSTEM CLEANING STATUS				"
echo "=================================================================================================="
$SshSessions.'10.254.216.213'.Runcommand('filesys clean status').Result
echo "=================================================================================================="
echo "						DATA DOMAIN REPLICATION STATUS				"
echo "=================================================================================================="
$SshSessions.'10.254.216.213'.Runcommand('replication status').Result
$SshSessions.'10.254.216.213'.Runcommand('replication show config').Result
Remove-SshSession -RemoveAll