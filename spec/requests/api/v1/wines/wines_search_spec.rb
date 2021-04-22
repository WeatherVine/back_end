require 'rails_helper'

RSpec.describe 'the wine search request' do
  describe 'happy path' do
    it 'returns correct structure' do
      VCR.use_cassette("wine_service_data") do

        get api_v1_wines_search_path(location: 'napa', vintage: '2018')

        expect(response).to be_successful
        data = JSON.parse(response.body, symbolize_names: true)

        expect(data.length).to eq(1)
        expect(data[:data]).to be_an(Array)
        expect(data[:data].length).to eq(5)

        first = data[:data].first
        expect(first.keys).to eq([:id, :type, :attributes])
        expect(first[:attributes].keys).to eq([:api_id, :name, :vintage, :area])

        second = data[:data].last
        expect(second.keys).to eq([:id, :type, :attributes])
        expect(second[:attributes].keys).to eq([:api_id, :name, :vintage, :area])
      end
    end

    it "returns correct content" do
      VCR.use_cassette("wine_service_data") do

        get api_v1_wines_search_path(location: 'napa', vintage: '2018')

        expect(response).to be_successful
        data = JSON.parse(response.body, symbolize_names: true)

        first = data[:data].first
        expect(first[:id]).to eq("5eeacc5a1ed9f43f0db3a803")
        expect(first[:type]).to eq('wine_search_result')
        attributes = first[:attributes]
        expect(attributes[:api_id]).to eq('5eeacc5a1ed9f43f0db3a803')
        expect(attributes[:name]).to eq('Bread & Butter Rosé 2018')
        expect(attributes[:vintage]).to eq('2018')
        expect(attributes[:area]).to eq('Napa Valley')


        second = data[:data].last
        expect(second[:id]).to eq('5e32fac2a0d5a356656a6e99')
        expect(second[:type]).to eq('wine_search_result')
        attributes = second[:attributes]
        expect(attributes[:api_id]).to eq('5e32fac2a0d5a356656a6e99')
        expect(attributes[:name]).to eq('Charles Krug Sauvignon Blanc')
        expect(attributes[:vintage]).to eq('2018')
        expect(attributes[:area]).to eq('Napa Valley')
      end
    end
  end
end
