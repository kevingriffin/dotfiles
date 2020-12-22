# Defined in /var/folders/6f/8y845b9d2lb39rjf0mqxr5m40000gn/T//fish.jMZrA6/replace_auth.fish @ line 2
function replace_auth --argument server username password client_auth
    if not test -n "$client_auth"
      set client_auth "Basic OTQ2YTc5MzMyZDRmYzAzNDY4ZjNlNjgwZTM5MTdlZGRlNzA2NTlkNzdlOTg1MGIyZTJjODZlODdiNWM3NDI5Mzo3MTI1YmQ0OTQxMmVjMzI2OWI1YjIzMmU3MDI1NDAzYzZmMjdkZTFkZGU0Njk5YTI3YTYwZDA0NTU4MDcwNjk4"
    end

    echo -n 'Authorization: Bearer '

    http -j post "https://$server/api/oauth/token" \
      grant_type=password scope=(replace_scopes $server) \
      username="$username" password="$password" \
      "Authorization: $client_auth" \
      | jq -r .access_token
end
