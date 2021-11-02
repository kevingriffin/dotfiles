# Defined in /var/folders/6f/8y845b9d2lb39rjf0mqxr5m40000gn/T//fish.Y77zc1/op-get-login.fish @ line 2
function op-get-login --argument login team
  if not test -n "$team"
    set team "my"
  end

  set -lx OP_SESSION_$team (op signin --raw $team)
  op get item "$login" | jq '.details.fields[] | select(.designation=="username").value, select(.designation=="password").value' | sed 's/"//g'
end
