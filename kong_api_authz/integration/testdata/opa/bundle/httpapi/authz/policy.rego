package httpapi.authz

# Deny access by default
default allow = false

# Mock baggage object
default baggage = {
  "baggage" : "TEST"
}

# Allows admin to access '/status' endpoints
allow {
  input.method == "GET"
  glob.match("/status**", ["/"], input.path)
  input.token.payload.role == "admin"
} 

# Allows to access '/baggage' endpoints and return user baggage
allow = baggage {
  input.method == "GET"
  glob.match("/headers**", ["/"], input.path)
} 