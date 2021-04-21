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
      expect(response).to respond_to("precip")
      expect(response).to respond_to("temp")
      expect(response).to respond_to("region")
      expect(response).to respond_to("start_date")
      expect(response).to respond_to("end_date")
    end

    it 'can test the data structure of the API data received from the call' do
      expected_raw = File.read('spec/fixtures/weather_show_results.json')
      json_result = JSON.parse!(expected_raw, symbolize_names: true)

      stub_microservice_request(json_result)

      response = WeatherService.fetch_weather('2015', 'napa valley')

      expect(json_result).to be_a(Hash)
      expect(json_result[:data][:id]).to eq("1")
      expect(json_result[:data][:type]).to eq("climate_data")
      expect(json_result[:data][:attributes]).to be_a(Hash)
      expect(json_result[:data][:attributes]).to have_key(:precip)
      expect(json_result[:data][:attributes][:precip]).to be_a(String)
      expect(json_result[:data][:attributes]).to have_key(:temp)
      expect(json_result[:data][:attributes][:temp]).to be_a(String)
      expect(json_result[:data][:attributes]).to have_key(:region)
      expect(json_result[:data][:attributes][:region]).to be_a(String)
      expect(json_result[:data][:attributes]).to have_key(:vintage)
      expect(json_result[:data][:attributes][:vintage]).to be_a(String)
      expect(json_result[:data][:attributes]).to have_key(:start_date)
      expect(json_result[:data][:attributes][:start_date]).to be_a(String)
      expect(json_result[:data][:attributes]).to have_key(:end_date)
      expect(json_result[:data][:attributes][:end_date]).to be_a(String)
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
