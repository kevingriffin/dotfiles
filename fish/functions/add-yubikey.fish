function add-yubikey
	yubikey-pin (hostname -s) | sed 's/"//g' | sshpass -P "Enter passphrase for PKCS#11" ssh-add -s /usr/local/lib/opensc-pkcs11.so
end
