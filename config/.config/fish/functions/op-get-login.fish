# Defined in /var/folders/6f/8y845b9d2lb39rjf0mqxr5m40000gn/T//fish.Y77zc1/op-get-login.fish @ line 2
function op-get-login --argument login team
  if not test -n "$team"
    set team "my"
  end

  set token "$(op signin --raw --account $team)"
  op --session "$token" item get --format json "$login" | jq '.fields[] | select(.id=="username").value, select(.id=="password").value' | sed 's/"//g'
end
