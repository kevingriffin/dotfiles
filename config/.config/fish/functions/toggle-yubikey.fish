function toggle-yubikey
	pkill ssh-agent
systemctl --user restart ssh-agent
ssh-add -s /usr/lib/opensc-pkcs11.so
end
