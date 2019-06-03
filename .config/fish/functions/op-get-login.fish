function op-get-login
	op get item "$argv[1]" | jq '.details.fields[] | select(.designation=="username").value, select(.designation=="password").value' 
end
