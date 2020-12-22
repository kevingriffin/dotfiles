# Defined in /var/folders/6f/8y845b9d2lb39rjf0mqxr5m40000gn/T//fish.tArrGk/dev_auth.fish @ line 2
function dev_auth --argument username
  if not test -n "$username"
    set username "kev@bibo.com.ph"
  end

  replace_auth 'localhost.devdomain.name:3000' "$username" 'Testing12345'
end
