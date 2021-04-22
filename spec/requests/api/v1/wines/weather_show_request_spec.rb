require 'rails_helper'

RSpec.describe 'the weather show request' do
  describe 'happy path' do
      it 'returns correct structure' do
        VCR.use_cassette("weather_show_request") do
        response = WeatherService.weather_connection.get("/api/v1/climate_data?vintage=2015&region=napa+valley")

        expect(response.success?).to eq(true)

        result = JSON.parse(response.body, symbolize_names: true)

        expect(result.length).to eq(1)
        expect(result.keys).to eq([:data])
        expect(result[:data].keys).to eq([:id, :type, :attributes])
        expect(result[:data][:attributes].keys).to eq([:temp, :precip, :vintage, :region, :start_date, :end_date])
      end
    end
  end
end
