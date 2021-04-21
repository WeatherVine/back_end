require 'rails_helper'
require 'ostruct'

RSpec.describe WeatherService do
  describe 'happy path' do
    it 'fetches weather data for a given year and region' do
      expected_raw = File.read('spec/fixtures/weather_show_results.json')
      expected = JSON.parse!(expected_raw, symbolize_names: true)

      stub_microservice_request(expected)
      response = WeatherService.fetch_weather('2015', 'napa valley')

      expect(response).to be_an(OpenStruct)
      # we need to add more expectations to test the structure
    end
  end
  def stub_microservice_request(body)
    full_url = "#{ENV['WEATHER_MICROSERVICE_URL']}/climate_data?vintage=2015&region=napa+valley"
    stub_request(:get, full_url)
      .to_return(
        status: 200,
        body: body.to_json,
        headers: {'Content-Type'=> 'application/json'}
      )
  end
end
