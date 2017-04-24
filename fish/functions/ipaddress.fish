function ipaddress
	ifconfig | grep "broadcast" | cut -d " " -f2 | head -n1
end
