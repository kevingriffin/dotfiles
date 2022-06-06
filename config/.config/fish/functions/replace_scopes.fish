# Defined in /var/folders/6f/8y845b9d2lb39rjf0mqxr5m40000gn/T//fish.zhSJMf/replace_scopes.fish @ line 2
function replace_scopes --argument server
  if not test -n "$server"
    set server "api.engoo.com"
  end
  xh "https://$server/api/types/abilities" | jq -r '.data.members | map(.enum_constant) | join(" ")'
end
