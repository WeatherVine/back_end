# Weather Vine Back End Application!
![IMG_0021](https://user-images.githubusercontent.com/72848529/115639403-ba284d00-a2d1-11eb-84b0-dc1973d4e42c.PNG)

## About this Project
Weather Vine is an educational app for consumers to connect more deeply with the wine they enjoy. Explore wines from a region and see how the climate has influenced the very wine one drinks!   

## Table of Contents

  - [Getting Started](#getting-started)
  - [Running the tests](#running-the-tests)
  - [Service Oriented Architecture](#service-oriented-architecture)
  - [DB Schema](#db-schema)
  - [Endpoints](#endpoints)
  - [Built With](#built-with)
  - [Contributing](#contributing)
  - [Versioning](#versioning)
  - [Authors](#authors)
  - [License](#license)
  - [Acknowledgments](#acknowledgments)

## Getting Started

To get the web application running, please fork and clone down the repo.
`git clone <your@github.account:WeatherVine/back_end.git>`

### Prerequisites

To run this application you will need Ruby 2.5.3 and Rails 5.2.5

### Installing

- Install the gem packages  
`bundle install`

- Create the database by running the following command in your terminal
`rails db{:drop, :create, :migrate}`

## Running the tests
RSpec testing suite is utilized for testing this application.
- Run the RSpec suite to ensure everything is passing as expected  
`bundle exec rspec`

## Service Oriented Architecture
The following is a depiction of the overall service oriented architecture for this application which includes a Rails Front End application, a Rails Engine on the Back End, and two microservices that call out to a World Weather Online's api and Quini Wine's api:

 ![service_oriented_architecture](https://user-images.githubusercontent.com/23460878/115339977-77e4fb80-a16b-11eb-8653-cf989f600b57.png)
 
## DB Schema
The following is a depiction of our Database Schema

 ![db_schema](https://user-images.githubusercontent.com/72848529/115637106-a62e1c80-a2cc-11eb-9892-1beec342e935.png)

## Endpoints
### User Dashboard Data
`GET https://weathervine-be.herokuapp.com/api/v1/users/:id/dashboard`
- **Required** path params:
  - `:id` - valid user id

>`GET https://weathervine-be.herokuapp.com/api/v1/users/1/dashboard`
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

### Wine Show Page Data
`GET https://weathervine-be.herokuapp.com/api/v1/wines/:api_id`
- **Required** path params:
  - `:api_id` - id used to access wine info from external wine API

>`GET https://weathervine-be.herokuapp.com/api/v1/wines/546e64cf4c6458020000000d`
>```json
>{
>  "data": {
>    "id": null,
>    "api_id": "546e64cf4c6458020000000d",
>    "name": "Duckhorn Sauvignon Blanc",
>    "area": "Napa Valley",
>    "vintage": "2018",
>    "eye": "",
>    "nose": "Citrus, Earthy aromas",
>    "mouth": "Citrus, Earthy flavours, Fresh acidity, Warm alcohol",
>    "finish": "Medium duration, Good quality, Middle peaktime",
>    "overall": "Subtle complexity, Pleasant interest, Harmonious balance",
>    "temp": "75",
>    "precip": "100",
>    "start_date": "2017-01-01",
>    "end_date": "2017-12-31"
>  }
>}
>```

### Create User Wine Data
`POST https://weathervine-be.herokuapp.com/api/v1/users/:user_id/wines`
- **Required** path params:
  - `wine_id`
  - `user_id`

- **Optional** path params:
  - `comment`

>`POST https://weathervine-be.herokuapp.com/api/v1/users/1/wines?wine_id=23&user_id=10&comment=this+comment`
>```json
>{
>  "data": {
>    "id": "#{new user wine id}",
>    "type": "user_wine",
>    "attributes": {
>      "wine_id": "23",
>      "user_id": "1",
>      "comment": "this comment"
>    }
>   }
> }
> ```

### Destroy User Wine Data
`DELETE https://weathervine-be.herokuapp.com/api/v1/users/:user_id/wines/:user_wine_id`

- **Required** path params:
  - `wine_id`
  - `user_id`

> `DELETE https://weathervine-be.herokuapp.com/api/v1/users/:user_id/wines/:user_wine_id?user_id=1&wine_id=12`
> ```json
> { "id": "#{user wine id}",
>   "wine_id": "12",
>   "user_id": "1",
>   "comment": "#{user wine comment}",
>   "created_at": "#{user wine created at}",
>   "updated_at": "#{user wine updated at}"


## Built With
- Ruby
- Rails
- RSpec
- FactoryBot
- Faker


## Versioning
- Ruby 2.5.3
- Rails 5.2.5

## Authors
- **Adam Bowers**
| [GitHub](https://github.com/Pragmaticpraxis37) |
  [LinkedIn](https://www.linkedin.com/in/adam-bowers-06a871209/)
- **Alex Schwartz**
| [GitHub](https://github.com/aschwartz1) |
  [LinkedIn](https://www.linkedin.com/in/alex-s-77659758/)
- **Diana Buffone**
| [GitHub](https://github.com/Diana20920) |
  [LinkedIn](https://www.linkedin.com/in/dianabuffone/)
- **Katy La Tour**
| [GitHub](https://github.com/klatour324) |
  [LinkedIn](https://www.linkedin.com/in/klatour324/)
- **Tommy Nieuwenhuis**
|  [GitHub](https://github.com/tsnieuwen) |
    [LinkedIn](https://www.linkedin.com/in/thomasnieuwenhuis/)
- **Trevor Suter**
|    [GitHub](https://github.com/trevorsuter) |
    [LinkedIn](https://www.linkedin.com/in/trevor-suter-216207203/)
- **Wil McCauley**
|    [GitHub](https://github.com/wil-mcc) |
    [LinkedIn](https://www.linkedin.com/in/wil-mccauley/)

