# README

This README would normally document whatever steps are necessary to get the application up and running.

Things you may want to cover:

* Rails version
5.2.5

### Endpoints
User Dashboard Page  
>`GET https://weathervine-be.herokuapp.com/api/v1/users/:id/dashboard`  
>```json
>{
>  "data": [
>    {
>      "id": 1,
>      "type": "favorite-wine",
>      "attributes": {
>        “api_id”: “1234”,
>        “name”: “Duckhorn Merlot”,
>        “comment”: “Totes the best.”
>      }
>    },
>    {
>      "id": 2,
>      "type": "favorite-wine",
>      "attributes": {
>        “api_id”: “2345”,
>        “name”: “Barefoot Cabernet Sauvignon”,
>        “comment”: “It’s a’ight.”
>      }
>    },
>    {
>      "id": 3,
>      "type": "favorite-wine",
>      "attributes": {
>        “api_id”: “3456”,
>        “name”: “Yellow Tail Pinot Noir”,
>        “comment”: “OMG”
>      }
>    }
>  ]
>}
>```
