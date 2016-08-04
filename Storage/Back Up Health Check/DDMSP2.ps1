Import-Module SSH-Sessions
New-SshSession -ComputerName 10.254.216.218 -Username "S0184551-A" -Password "abcd1234"
echo "=================================================================================================="
$SshSessions.'10.254.216.218'.Runcommand('hostname').Result
echo "=================================================================================================="
echo "=================================================================================================="
echo "						DATA DOMAIN ALERTS					"
echo "=================================================================================================="
$SshSessions.'10.254.216.218'.Runcommand('alerts show current').Result
echo "=================================================================================================="
echo "					DATA DOMAIN FILESYSTEM STATUS					"
echo "=================================================================================================="
$SshSessions.'10.254.216.218'.Runcommand('df').Result
echo "=================================================================================================="
echo "					DATA DOMAIN FILESYSTEM CLEANING STATUS				"
echo "=================================================================================================="
$SshSessions.'10.254.216.218'.Runcommand('filesys clean status').Result
echo "=================================================================================================="
echo "						DATA DOMAIN REPLICATION STATUS				"
echo "=================================================================================================="
$SshSessions.'10.254.216.218'.Runcommand('replication status').Result
$SshSessions.'10.254.216.218'.Runcommand('replication show config').Result
Remove-SshSession -RemoveAll