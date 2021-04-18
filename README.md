# README

This README would normally document whatever steps are necessary to get the application up and running.

Things you may want to cover:

* Rails version
5.2.5

# Endpoints
### User Dashboard Data
>`GET https://weathervine-be.herokuapp.com/api/v1/users/:id/dashboard`
>```json
>{
>  "data": [
>    {
>      "id": 1,
>      "type": "favorite-wine",
>      "attributes": {
>        "api_id": "1234",
>        "name": "Duckhorn Merlot",
>        "comment": "Totes the best."
>      }
>    },
>    {
>      "id": 2,
>      "type": "favorite-wine",
>      "attributes": {
>        "api_id": "2345",
>        "name": "Barefoot Cabernet Sauvignon",
>        "comment": "It’s a'ight."
>      }
>    },
>    {
>      "id": 3,
>      "type": "favorite-wine",
>      "attributes": {
>        "api_id": "3456",
>        "name": "Yellow Tail Pinot Noir",
>        "comment": "OMG"
>      }
>    }
>  ]
>}
>```

### Wine Search Results Data
- **Required** query params:
  - `location`
  - `vintage`

>`GET https://weathervine-be.herokuapp.com/api/v1/wines/search?location=napa&vintage=2018`
>```json
>{
>  "data": [
>    {
>      "id": "5f065fb5fbfd6e17acaad294",
>      "type": "wine_search_result",
>      "attributes": {
>        "api_id": "5f065fb5fbfd6e17acaad294",
>        "name": "Duckhorn The Discussion Red 2012",
>        "vintage": "2018",
>        "location": "Napa Valley"
>      }
>    },
>    {
>      "id": "546e64cf4c6458020000000d",
>      "type": "wine_search_result",
>      "attributes": {
>        "api_id": "546e64cf4c6458020000000d",
>        "name": "Duckhorn",
>        "vintage": "2018",
>        "location": "Napa Valley"
>      }
>    }
>  ]
>}
>```
