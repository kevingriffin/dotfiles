function vpn
	sudo ip netns exec "$argv[1]" su (whoami)
end
