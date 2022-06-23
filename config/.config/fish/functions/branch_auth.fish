# Defined in /var/folders/6f/8y845b9d2lb39rjf0mqxr5m40000gn/T//fish.oZHCp4/branch_auth.fish @ line 2

function branch_auth --argument branch username password
  replace_auth (branch_token "$branch" "$username" "$password")
end
