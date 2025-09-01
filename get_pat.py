from dremio_simple_query.connect import get_token

payload = {
    "userName": "your-username",
    "password": "your-password"
}
token = get_token(uri="http://localhost:9047/apiv2/login", payload=payload)

print("------TOKEN BELOW-------")
print(token)
print("------TOKEN ABOVE-------")