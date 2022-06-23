# Defined in /var/folders/6f/8y845b9d2lb39rjf0mqxr5m40000gn/T//fish.Xpkp9r/replace_auth.fish @ line 2
function replace_auth --argument token
    echo -n 'Authorization: Bearer '
    echo -n "$token"
end
