function op-get-password
  set -lx OP_SESSION_my (op signin --raw)
	op get item "$argv[1]" | jq '.details.password'
end
