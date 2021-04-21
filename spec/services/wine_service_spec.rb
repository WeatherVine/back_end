require 'rails_helper'
require 'ostruct'

RSpec.describe WineService do
  describe 'happy path' do
    it 'fetches wine data and returns the correct object' do
      expected_raw = File.read('spec/fixtures/wine_show_page_results.json')
      json_result = JSON.parse!(expected_raw, symbolize_names: true)

      stub_microservice_request(json_result)

      response = WineService.fetch_wine("5f065fb5fbfd6e17acaad294")
      expect(response).to be_an(OpenStruct)
      expect(response).to respond_to("api_id")
      expect(response).to respond_to("name")
      expect(response).to respond_to("vintage")
      expect(response).to respond_to("area")
    end

    it 'can test the data structure of the API data received from the call' do
      expected_raw = File.read('spec/fixtures/wine_show_page_results.json')
      json_result = JSON.parse!(expected_raw, symbolize_names: true)

      stub_microservice_request(json_result)

      response = WineService.fetch_wine("5f065fb5fbfd6e17acaad294")

      expect(json_result).to be_a(Hash)
      expect(json_result[:data][:attributes]).to be_a(Hash)
      expect(json_result[:data][:attributes]).to have_key(:api_id)
      expect(json_result[:data][:attributes][:api_id]).to be_a(String)
      expect(json_result[:data][:attributes]).to have_key(:name)
      expect(json_result[:data][:attributes][:name]).to be_a(String)
      expect(json_result[:data][:attributes]).to have_key(:area)
      expect(json_result[:data][:attributes][:area]).to be_a(String)
      expect(json_result[:data][:attributes]).to have_key(:vintage)
      expect(json_result[:data][:attributes][:vintage]).to be_a(String)
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
