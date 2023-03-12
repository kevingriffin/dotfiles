# Defined in /var/folders/6f/8y845b9d2lb39rjf0mqxr5m40000gn/T//fish.tArrGk/dev_auth.fish @ line 2
function dev_auth --argument subdomain username
  if not test -n "$username"
    set username "kev@bibo.com.ph"
  end

  if not test -n "$subdomain"
    set subdomain "api"
  end

  replace_auth (dev_token $subdomain $username)
end
