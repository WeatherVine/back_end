require 'rails_helper'

RSpec.describe 'the wine search request' do
  describe 'happy path' do
    it 'returns correct structure' do
      expected_raw = File.read('spec/fixtures/wines_search_results.json')
      expected = JSON.parse!(expected_raw, symbolize_names: true)

      full_url = "#{ENV['WEATHER_MICROSERVICE_URL']}/api/v1/search?region=napa&vintage=2018"
      # stub_request(:get, full_url).to_return(body: expected.to_s)
      stub_request(:get, full_url)
        .to_return(
          status: 200,
          body: expected_raw,
          headers: {'Content-Type'=> 'application/json'}
        )

      get api_v1_wines_search_path

      expect(response).to be_successful
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data.length).to eq(1)
      expect(data[:data]).to be_an(Array)
      expect(data[:data].length).to eq(2)

      first = data[:data].first
      expect(first.keys).to eq([:id, :type, :attributes])
      expect(first[:attributes].keys).to eq([:api_id, :name, :vintage, :region])

      second = data[:data].second
      expect(second.keys).to eq([:id, :type, :attributes])
      expect(second[:attributes].keys).to eq([:api_id, :name, :vintage, :region])
    end

    it "returns correct content" do
      expected_raw = File.read('spec/fixtures/wines_search_results.json')
      expected = JSON.parse!(expected_raw, symbolize_names: true)

      full_url = "#{ENV['WEATHER_MICROSERVICE_URL']}/api/v1/search?region=napa&vintage=2018"
      stub_request(:get, full_url).to_return(body: expected)

      get api_v1_wines_search_path

      expect(response).to be_successful
      data = JSON.parse(response.body, symbolize_names: true)
      first = data.first
      first = data.last


    end
  end
  # describe 'sad path' do
    # it '' do
    # end
  # end
end
=begin
{"data":[{"id":"1","type":"wine","attributes":{"api_id":"5f065fb5fbfd6e17acaad294","name":"Duckhorn The Discussion Red 2012","vintage":"2018","region":"Napa Valley"}},{"id":"2","type":"wine","attributes":{"api_id":"546e64cf4c6458020000000d","name":"Duckhorn","vintage":"2018","region":"Napa Valley"}}]}
=end

# res = File.read('spec/fixtures/wines_search_results.json')
# out = JSON.parse(res)

# expect(res[:data].length).to eq(2)
