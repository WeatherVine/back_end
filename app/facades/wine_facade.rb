class WineFacade
  def self.fetch_weather_info(vintage, region)
    WeatherService.fetch_weather(vintage, region)
  end

  def self.fetch_wine_info(wine_api_id)
    WineService.fetch_wine(wine_api_id)
  end

  def self.fetch_all_the_things(wine_api_id)
    # Need to get weather info
    wine_data = fetch_wine_info(wine_api_id)

    weather_data = fetch_weather_info(wine_data.vintage, wine_data.area)
    # Need to combine the two (and return the value)
    combine_data(wine_data, weather_data)
  end

  def self.combine_data(wine_data, weather_data)
    # TODO: should we change how this works
    #   e.g. leave the wine & weather data to be hashes (& not ostructs)
    #        So we can save the data transforming time/cost
    merged = wine_data.to_h.merge(weather_data.to_h)
    merged[:id] = nil
    OpenStruct.new(merged)
  end
end
