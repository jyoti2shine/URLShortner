# URL Shortner CheatSheet

This Cheatsheet Provides the API Endpoints and Usages .

_Everytime(Except User Creation & Short URL Display) API TOKEN Needs to be passed in Headers with Key Authorization and Value Token API_TOKEN_

| API URL              | METHOD        | DATA                  | Response |
| -------------        |:-------------:| -----:                | -----:   |
| /users               | POST          | {:email,:password,:name} | User Name with API TOKEN |
| /users/authenticate  | GET           | Authorization: Token APITOKEN           | Authorized  |
| /users/regenerate_token| POST      |   {:email,:password,:name}                | NEW APITOKEN|
| /short_urls| GET      |   N/A               | LIST OF SHORTURLS |
| /short_urls?page=1| GET      |   N/A (If No Page number Passed default will be 1)              | LIST OF SHORTURLS Paginated : Perpage 10 |
| /:shorty| GET[HTTP]      |  :shorty => Short URL               | Displays the Original URL |
| /short_urls| POST      |   {:original_url}                | Short URL Details |
| /short_urls/:shorty | DELETE      |     :shorty => Short URL               | Deletion Status |
| /:shorty/geo_detail| GET      |  :shorty => Short URL                  | GEO Location Details |
| /:shorty/geo_detail?page=:page_num| GET      |  :shorty => Short URL ,:page_num => Page Number (Perpage 10)| GEO Location Details |


# Example using Curl 

`curl -H "Authorization: Token token=fda143031ecc4ccda257169979c54278" http://localhost:3000/users/authenticate
`

# Example using PostMan
 
![alt tag](https://raw.githubusercontent.com/jyoti2shine/URLShortner/master/public/PostManRequest.png)
