class WeatherFacade
  def self.weather_connection
    @weather_connection ||= Faraday.new({
      url: ENV['WEATHER_MICROSERVICE_URL']
    })
  end

  def self.fetch_weather(vintage, region)
    response = fetch_raw_weather_data(vintage, region)
    data = JSON.parse(response.body, symbolize_names: true)
    data_struct = format_weather_data(data)
  end

  def self.fetch_raw_weather_data(vintage, region)
    weather_connection.get("/climate_data?vintage=#{vintage}&region=#{region}")
  end

  def self.format_weather_data(data)
    weather = data[:data][:attributes]
    require "pry"; binding.pry
    OpenStruct.new({
      precip:     weather[:precip],
      temp:       weather[:temp],
      region:     weather[:region],
      vintage:    weather[:vintage],
      start_date: weather[:start_date],
      end_date:   weather[:end_date]
    })
  end

end
