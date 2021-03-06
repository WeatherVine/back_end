require 'rails_helper'
require 'ostruct'

RSpec.describe WeatherService do
  describe 'happy path' do
    it 'fetches weather data for a given year and region' do
      VCR.use_cassette("weather_service_data") do

        response = WeatherService.fetch_weather('2015', 'napa valley')
        expect(response).to be_an(OpenStruct)
        expect(response).to respond_to("temp")
        expect(response).to respond_to("precip")
        expect(response).to respond_to("start_date")
        expect(response).to respond_to("end_date")
      end
    end

    it 'can test the data structure of the API data received from the call' do
      VCR.use_cassette("weather_service_data") do
        response = WeatherService.fetch_weather('2015', 'napa valley')

        expect(response.temp).to eq(81)
        expect(response.precip).to eq(61.0)
        expect(response.start_date).to eq("2014-01-01")
        expect(response.end_date).to eq("2014-12-31")
      end
    end
  end
end
