# Defined in /var/folders/6f/8y845b9d2lb39rjf0mqxr5m40000gn/T//fish.oZHCp4/branch_auth.fish @ line 2
function branch_auth --argument branch username
  if not test -n "$branch"
    set branch "master"
  end

  if not test -n "$username"
    set username "kev@bibo.com.ph"
  end

  set server "$branch.api.branch.eikaiwa.dmm.com"
  set password (op-get-login "replace-auth" "team_engoo" | tail -n1)
  echo $server $username $password
  replace_auth "$server" "$username" "$password"
end
