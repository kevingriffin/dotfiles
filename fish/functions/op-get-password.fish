function op-get-password
	op get item "$argv[1]" | jq '.details.password' 
end
