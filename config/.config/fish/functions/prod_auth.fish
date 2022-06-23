# Defined in /var/folders/6f/8y845b9d2lb39rjf0mqxr5m40000gn/T//fish.JZPAuY/prod_auth.fish @ line 2
function prod_auth --argument username password
  replace_auth (prod_token "$username" "$password")
end
