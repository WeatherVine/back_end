class WineFacade
  # def self.fetch_raw_wine_data(api_id)
  #   wine_connection.get("/api/v1/wine-single?id=#{api_id}")
  # end
  #
  # def self.wine_connection
  #   wine_connection ||= Faraday.new({
  #     url: ENV['WINE_MICROSERVICE_URL']
  #   })
  # end

  def self.fetch_weather_info(vintage, region)
    WeatherService.fetch_weather(vintage, region)
  end

  def self.fetch_wine_info(wine_api_id)
    WineService.fetch_wine(wine_api_id)
  end

  def self.fetch_all_the_things(wine_api_id)
    # Need to get wine info
    # response = fetch_raw_wine_data(wine_api_id)
    # parsed_response = JSON.parse(response.body, symbolize_names: true)
    # formatted_wine_data = format_wine_data(parsed_response[:data])

    # Need to get weather info
    wine_data = self.fetch_wine_info(wine_api_id)

    weather_data = self.fetch_weather_info(wine_data.vintage, wine_data.area)
    # Need to combine the two (and return the value)
    combine_data(wine_data, weather_data)
  end

  # def self.format_wine_data(data)
  #   wine = data[:attributes]
  #   OpenStruct.new({
  #     api_id: wine[:api_id],
  #     name: wine[:name],
  #     area: wine[:area],
  #     vintage: wine[:vintage],
  #     eye: wine[:eye],
  #     nose: wine[:nose],
  #     mouth: wine[:mouth],
  #     finish: wine[:finish],
  #     overall: wine[:overall]
  #   })
  # end

  def self.combine_data(wine_data, weather_data)
    # TODO: should we change how this works
    #   e.g. leave the wine & weather data to be hashes (& not ostructs)
    #        So we can save the data transforming time/cost
    merged = wine_data.to_h.merge(weather_data.to_h)
    merged[:id] = nil
    OpenStruct.new(merged)
  end

  # def fetch_all_the_things(wine_api_id)
  #   # Need to get wine info
  #   response = fetch_raw_wine_data(wine_api_id)
  #   parsed_response = JSON.parse(response.body, symbolize_names: true)
  #   formatted_wine_data = format_wine_data(parsed_response[:data])
  # end
end
