require 'rails_helper'

RSpec.describe 'the weather show request' do
  describe 'happy path' do
    it 'returns correct ostruct' do
      expected_raw = File.read('spec/fixtures/weather_show_results.json')
      expected = JSON.parse!(expected_raw, symbolize_names: true)

      stub_microservice_request(expected)
      response = WeatherFacade.weather_connection.get("/climate_data?vintage=2015&region=napa+valley")

      expect(response.success?).to eq(true)
      result = JSON.parse(response.body, symbolize_names: true)

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
