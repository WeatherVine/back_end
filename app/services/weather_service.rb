class WeatherService
  def self.weather_connection
    @weather_connection ||= Faraday.new({
      url: ENV['WEATHER_MICROSERVICE_URL']
    })
  end

  def self.fetch_weather(vintage, region)
    # return OpenStruct.new({
    #   temp: '50',
    #   precip: '0.1',
    #   start_date: '2014-01-01',
    #   end_date: '2014-12-31'
    #   })
    response = fetch_raw_weather_data(vintage, region)
    data = JSON.parse(response.body, symbolize_names: true)
    format_weather_data(data)
  end

  def self.fetch_raw_weather_data(vintage, region)
    weather_connection.get("/api/v1/climate_data?vintage=#{vintage}&region=#{region}")
  end

  def self.format_weather_data(data)
    weather = data[:data][:attributes]
    OpenStruct.new({
      precip: weather[:precip],
      temp: weather[:temp],
      region: weather[:region],
      start_date: weather[:start_date],
      end_date: weather[:end_date]
    })
  end
end
