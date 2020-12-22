# Defined in /var/folders/6f/8y845b9d2lb39rjf0mqxr5m40000gn/T//fish.RxhFyh/add-yubikey.fish @ line 2
function add-yubikey
	yubikey-pin (hostname -s) | sshpass -P "Enter passphrase for PKCS#11" ssh-add -s /usr/local/lib/opensc-pkcs11.so
end
