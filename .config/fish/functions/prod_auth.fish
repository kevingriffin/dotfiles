# Defined in /var/folders/6f/8y845b9d2lb39rjf0mqxr5m40000gn/T//fish.oMeaku/prod_auth.fish @ line 1
function prod_auth --argument username
  if not test -n "$username"
    set username "kev@bibo.com.ph"
  end

  set server "api.engoo.com"
  set password (op-get-login "replace-auth" "team_engoo" | tail -n1)
  echo $server $username $password
  replace_auth "$server" "$username" "$password"
end
