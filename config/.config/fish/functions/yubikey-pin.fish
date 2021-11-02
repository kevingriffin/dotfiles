# Defined in /var/folders/6f/8y845b9d2lb39rjf0mqxr5m40000gn/T//fish.FgTJjP/yubikey-pin.fish @ line 2
function yubikey-pin
	op-get-password "$argv[1] YubiKey"
end
