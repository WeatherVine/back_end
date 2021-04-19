class Api::V1::WinesController < ApplicationController
  def show
    wine_show_data = fetch_all_the_things(params[:id])
    render json: WineWeatherSerializer.new(wine_show_data)
  end
end

def fetch_all_the_things(wine_api_id)
  # Need to get wine info
  response = fetch_raw_wine_data(wine_api_id)
  parsed_response = JSON.parse(response.body, symbolize_names: true)
  formatted_wine_data = format_wine_data(parsed_response[:data])

  # Need to get weather info
  formatted_weather_data = fake_weather_data

  # Need to combine the two (and return the value)
  combine_data(formatted_wine_data, formatted_weather_data)
end

def fetch_raw_wine_data(api_id)
  wine_connection.get("/api/v1/wine-single?id=#{api_id}")
end

# Disabling rubocop method length for this method, since it's over the length
#   but only because we are declaring each hash kvp on it's own line
# rubocop:disable Metrics/MethodLength
def format_wine_data(data)
  wine = data[:attributes]
  OpenStruct.new({
    api_id: wine[:api_id],
    name: wine[:name],
    area: wine[:area],
    vintage: wine[:vintage],
    eye: wine[:eye],
    nose: wine[:nose],
    mouth: wine[:mouth],
    finish: wine[:finish],
    overall: wine[:overall]
  })
end
# rubocop:enable Metrics/MethodLength

def wine_connection
  @wine_connection ||= Faraday.new({
    url: ENV['WINE_MICROSERVICE_URL']
  })
end

def fake_weather_data
  OpenStruct.new({
    temp: '55',
    precip: '20',
    start_date: '2018-01-01',
    end_date: '2018-12-31'
  })
end

def combine_data(wine_data, weather_data)
  # TODO: should we change how this works
  #   e.g. leave the wine & weather data to be hashes (& not ostructs)
  #        So we can save the data transforming time/cost
  merged = wine_data.to_h.merge(weather_data.to_h)
  merged[:id] = nil
  OpenStruct.new(merged)
end
