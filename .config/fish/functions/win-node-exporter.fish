function win-node-exporter
	pushd /mnt/c/Apps
msiexec.exe /i wmi_exporter-0.7.999-amd64.msi ENABLED_COLLECTORS=cpu,cs,logical_disk,memory,net,tcp,os,service LISTEN_PORT=9100
popd
end
