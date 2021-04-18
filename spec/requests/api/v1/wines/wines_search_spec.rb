require 'rails_helper'

RSpec.describe 'the wine search request' do
  describe 'happy path' do
    it 'returns correct structure' do
      expected_raw = File.read('spec/fixtures/wines_search_results.json')
      expected = JSON.parse!(expected_raw, symbolize_names: true)

      stub_microservice_request(expected)

      get api_v1_wines_search_path(location: 'napa', vintage: '2018')

      expect(response).to be_successful
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data.length).to eq(1)
      expect(data[:data]).to be_an(Array)
      expect(data[:data].length).to eq(2)

      first = data[:data].first
      expect(first.keys).to eq([:id, :type, :attributes])
      expect(first[:attributes].keys).to eq([:api_id, :name, :vintage, :location])

      second = data[:data].last
      expect(second.keys).to eq([:id, :type, :attributes])
      expect(second[:attributes].keys).to eq([:api_id, :name, :vintage, :location])
    end

    it "returns correct content" do
      expected_raw = File.read('spec/fixtures/wines_search_results.json')
      expected = JSON.parse!(expected_raw, symbolize_names: true)

      stub_microservice_request(expected)

      get api_v1_wines_search_path(location: 'napa', vintage: '2018')

      expect(response).to be_successful
      data = JSON.parse(response.body, symbolize_names: true)

      first = data[:data].first
      expect(first[:id]).to eq("5f065fb5fbfd6e17acaad294")
      expect(first[:type]).to eq('wine_search_result')
      attributes = first[:attributes]
      expect(attributes[:api_id]).to eq('5f065fb5fbfd6e17acaad294')
      expect(attributes[:name]).to eq('Duckhorn The Discussion Red 2012')
      expect(attributes[:vintage]).to eq('2018')
      expect(attributes[:location]).to eq('Napa Valley')


      second = data[:data].last
      expect(second[:id]).to eq('546e64cf4c6458020000000d')
      expect(second[:type]).to eq('wine_search_result')
      attributes = second[:attributes]
      expect(attributes[:api_id]).to eq('546e64cf4c6458020000000d')
      expect(attributes[:name]).to eq('Duckhorn')
      expect(attributes[:vintage]).to eq('2018')
      expect(attributes[:location]).to eq('Napa Valley')
    end
  end

  def stub_microservice_request(body)
    full_url = "#{ENV['WINE_MICROSERVICE_URL']}/wine-data?location=napa&vintage=2018"
    stub_request(:get, full_url)
      .to_return(
        status: 200,
        body: body.to_json,
        headers: {'Content-Type'=> 'application/json'}
      )
  end
end
