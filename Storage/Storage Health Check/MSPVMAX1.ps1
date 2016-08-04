echo "=================================================================================================="
echo "						MSP VMAX SPACE DETAILS					"
echo "=================================================================================================="

cmd /c symcfg -sid 3469 list -thin -pool -gb -detail

echo "=================================================================================================="
echo "						MSP VMAX HEALTH STATUS					"
echo "=================================================================================================="

cmd /c symcfg -sid 3469 list -env_data

echo "=================================================================================================="
echo "						MSP VMAX FAILED DEVICE STATUS					"
echo "=================================================================================================="

cmd /c symcfg -sid 69 list -env_data -service_state failed

echo "=================================================================================================="
echo "						MSP VMAX DISK FAILEDSTATUS					"
echo "=================================================================================================="

cmd /c symdisk -sid 69 list -failed

echo "=================================================================================================="
echo "						MSP VMAX EVENTS						"
echo "=================================================================================================="


cmd /c symevent list -sid 3469  -v