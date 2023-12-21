function replace_simple_token --argument server username password client_auth protocol
    if not test -n "$client_auth"
      set client_auth "Basic OTQ2YTc5MzMyZDRmYzAzNDY4ZjNlNjgwZTM5MTdlZGRlNzA2NTlkNzdlOTg1MGIyZTJjODZlODdiNWM3NDI5Mzo3MTI1YmQ0OTQxMmVjMzI2OWI1YjIzMmU3MDI1NDAzYzZmMjdkZTFkZGU0Njk5YTI3YTYwZDA0NTU4MDcwNjk4"
    end

    if not test -n "$protocol"
      set protocol "https"
    end

    xh -j post "$protocol://$server/api/oauth/token" \
      grant_type=password scope="allUnprivileged" \
      username="$username" password="$password" \
      brand="5a4657f2-e151-4c48-9cce-000000000006" \
      "Authorization: $client_auth" \
    | jq -r .access_token
end
