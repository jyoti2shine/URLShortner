# URL Shortner CheatSheet

This Cheatsheet Provides the API Endpoints and Usages .

_Everytime(Except User Creation & Short URL Display) API TOKEN Needs to be passed in Headers with Key Authorization and Value Token API_TOKEN_

| API URL              | METHOD        | DATA                  | Response |
| -------------        |:-------------:| -----:                | -----:   |
| /users               | POST          | {:email,:password,:name} | User Name with API TOKEN |
| /users/authenticate  | GET           | Authorization: Token APITOKEN           | Authorized  |
| /users/regenerate_token| POST      |   {:email,:password,:name}                | NEW APITOKEN|
| /short_urls| GET      |   N/A               | LIST OF SHORTURLS |
| /short_urls/:shorty| GET[HTTP]      |  :shorty => Short URL               | Displays the Original URL |
| /short_urls| POST      |   {:original_url}                | Short URL Details |
| /short_urls/:shorty | DELETE      |     :shorty => Short URL               | Deletion Status |
| /:shorty/geo_detail| GET      |  :shorty => Short URL                  | GEO Location Details |

