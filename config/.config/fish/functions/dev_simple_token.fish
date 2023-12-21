function dev_simple_token --argument subdomain username
  if not test -n "$domain"
    set subdomain "api"
  end

  if not test -n "$username"
    set username "kev@bibo.com.ph"
  end

  set server "$subdomain.devdomain.name:3001"

  set password "Testing12345"

  set client_auth "Basic OTQ2YTc5MzMyZDRmYzAzNDY4ZjNlNjgwZTM5MTdlZGRlNzA2NTlkNzdlOTg1MGIyZTJjODZlODdiNWM3NDI5Mzo3MTI1YmQ0OTQxMmVjMzI2OWI1YjIzMmU3MDI1NDAzYzZmMjdkZTFkZGU0Njk5YTI3YTYwZDA0NTU4MDcwNjk4"

  replace_simple_token "$server" "$username" "$password" "$client_auth" "http"
end
