echo off
echo "=========================================================================================================================="
echo "						FOR ARRAYNAME DETAILS								"
echo "=========================================================================================================================="

cmd /c naviseccli -h 10.243.86.98 getall | find "Array Name"

cmd /c naviseccli -h 10.243.86.98 getagent | find "Serial No"

echo "=========================================================================================================================="
echo "						FOR VNX POOL SPACE DETAILS								"
echo "=========================================================================================================================="

cmd /c naviseccli -h 10.243.86.98 storagepool -list -availableCap -consumedCap -UserCap -prcntFull | findstr "Pool GBs percent"

echo "=========================================================================================================================="
echo "						FOR VNX RAIDGROUP SPACE DETAILS								"
echo "=========================================================================================================================="

cmd /c naviseccli -h 10.243.86.98 getrg -disks -legal -hotspare -tcap | findstr "RaidGroup Legal Logical Capacity"

echo "=========================================================================================================================="
echo "						FOR VNX HEALTH STATUS								"
echo "=========================================================================================================================="

cmd /c naviseccli -h 10.243.86.98 faults -list


echo "=========================================================================================================================="
echo "						FOR VNX EVENTS									"
echo "=========================================================================================================================="

cmd /c naviseccli -h 10.243.86.98 getlog -30

