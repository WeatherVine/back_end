class Api::V1::Wines::SearchController < ApplicationController
  def index
    render json: WineSearchResultSerializer.new(fetch_search_results(params[:location], params[:vintage]))
  end

  private

  def fetch_search_results(location, vintage)
    response = wine_service_connection.get("/wine-data?location=#{location}&vintage=#{vintage}")
    wines = JSON.parse(response.body, symbolize_names: true)

    format_wine_response(wines[:data])
  end

  def wine_service_connection
    @wine_service_connection ||= Faraday.new({
      url: ENV['WINE_MICROSERVICE_URL']
    })
  end

  def format_wine_response(wines)
    wines.map do |wine|
      attributes = wine[:attributes]
      OpenStruct.new({
        api_id: attributes[:api_id],
        name: attributes[:name],
        vintage: attributes[:vintage],
        location: attributes[:area]
      })
    end
  end
end
