# Kabuni CheatSheet

This Cheatsheet Provides the API Endpoints and Usages .

| API URL              | METHOD        | DATA                  | Response |
| -------------        |:-------------:| -----:                | -----:   |
| /users               | POST          | {:email,:password,:name} | User Name with API TOKEN |
| /users/authenticate  | GET           | Authorization: Token APITOKEN           | Authorized  |
| /users/regenerate_token | POST      |   {:email,:password,:name}                | NEW APITOKEN|
