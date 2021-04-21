require 'rails_helper'
require 'ostruct'

RSpec.describe WineService do
  describe 'happy path' do
    it 'fetches wine data and returns the correct object' do
      expected_raw = File.read('spec/fixtures/wine_show_page_results.json')
      expected = JSON.parse!(expected_raw, symoblize_names: true)

      stub_microservice_request(expected)

      response = WineService.fetch_wine("5f065fb5fbfd6e17acaad294")
      expect(response).to be_an(OpenStruct)
      expect(response).to respond_to("api_id")
      expect(response).to respond_to("name")
      expect(response).to respond_to("vintage")
      expect(response).to respond_to("area")
    end
  end

  def stub_microservice_request(body)
    full_url = "#{ENV['WINE_MICROSERVICE_URL']}/api/v1/wine-single?id=5f065fb5fbfd6e17acaad294"
    stub_request(:get, full_url)
    .to_return(
      status: 200,
      body: body.to_json,
      headers: {'Content-Type'=> 'application/json'}
    )
  end
end
