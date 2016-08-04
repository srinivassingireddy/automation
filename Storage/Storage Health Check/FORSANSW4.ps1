Import-Module SSH-Sessions
New-SshSession -ComputerName 10.242.18.123 -Username "S0191806-A" -Password "Storage@123"


echo "=================================================================================================="
echo "						MSP SANSWITCH HARDWARE STATUS				"
echo "=================================================================================================="
$SshSessions.'10.242.18.123'.Runcommand('show hardware').Result
echo "=================================================================================================="
echo "						MSP SANSWITCH ENVIRONMET STATUS				"
echo "=================================================================================================="

$SshSessions.'10.242.18.123'.Runcommand('show env').Result
echo "=================================================================================================="
echo "						MSP SANSWITCH INTERFACE STATUS				"
echo "=================================================================================================="
$SshSessions.'10.242.18.123'.Runcommand('sh int br').Result
echo "=================================================================================================="
echo "						MSP SANSWITCH LOG STATUS				"
echo "=================================================================================================="
$SshSessions.'10.242.18.123'.Runcommand('sh log last 30').Result
echo "=================================================================================================="
echo "						MSP SANSWITCH LOG CLEAR STATUS				"
echo "=================================================================================================="
$SshSessions.'10.242.18.123'.Runcommand('clear counters interface all').Result
Remove-SshSession -RemoveAll