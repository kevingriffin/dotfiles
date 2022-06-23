function prod_token --argument username password
  if test -n "$REPLACE_PROD_TOKEN"
    echo -n "$REPLACE_PROD_TOKEN"
    return 0
  end

  if not test -n "$username"
    set username "kev@bibo.com.ph"
  end

  set server "api.engoo.com"

  if not test -n "$password"
    set password (op-get-login "replace-auth" "team_engoo" | tail -n1)
  end

  replace_token "$server" "$username" "$password"
end
