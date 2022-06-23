function branch_token --argument branch username
  if test -n "$REPLACE_BRANCH_TOKEN"
    echo -n "$REPLACE_BRANCH_TOKEN"
    return 0
  end

  if not test -n "$branch"
    set branch "master"
  end

  if not test -n "$username"
    set username "kev@bibo.com.ph"
  end

  set server "$branch.api.branch.engoo.com"

  if not test -n "$password"
    set password (op-get-login "replace-auth" "team_engoo" | tail -n1)
  end

  replace_token "$server" "$username" "$password"
end
