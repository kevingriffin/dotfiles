# Defined in /var/folders/61/007mjl_j1qj7bk_zn1j0gj4c0000gn/T//fish.Jrgh5o/toggle-nginx.fish @ line 2
function toggle-nginx
	if test (uname) = "Darwin"
    sudo launchctl unload /Library/LaunchDaemons/org.nixos.nginx.plist
    sudo launchctl load /Library/LaunchDaemons/org.nixos.nginx.plist
  else if test (uname) = "Linux"
    sudo launchctl unload /Library/LaunchDaemons/org.nixos.nginx.plist
    sudo launchctl load /Library/LaunchDaemons/org.nixos.nginx.plist
  end
end
