class WineService
  def self.fetch_raw_wine_data(api_id)
    wine_connection.get("/api/v1/wine-single?id=#{api_id}")
  end

  def self.wine_connection
    @wine_connection ||= Faraday.new({
      url: ENV['WINE_MICROSERVICE_URL']
    })
  end

  # Disabling rubocop method length for this method, since it's over the length
  #   but only because we are declaring each hash kvp on it's own line
  # rubocop:disable Metrics/MethodLength
  def self.format_wine_data(data)
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

  def self.fetch_wine(wine_api_id)
    # Need to get wine info
    response = fetch_raw_wine_data(wine_api_id)
    parsed_response = JSON.parse(response.body, symbolize_names: true)
    format_wine_data(parsed_response[:data])
  end
end
