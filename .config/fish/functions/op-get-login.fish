function op-get-login
  set -lx OP_SESSION_my (op signin --raw)
	op get item "$argv[1]" | jq '.details.fields[] | select(.designation=="username").value, select(.designation=="password").value'
end
