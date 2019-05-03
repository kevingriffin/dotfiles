function yubikey-pin
	oplogin | op-get-password "$argv[1] YubiKey"
end
