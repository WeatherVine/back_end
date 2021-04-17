require 'rails_helper'

RSpec.describe 'the wine search request' do
  describe 'happy path' do
    it 'returns correct structure' do
      get api_v1_wines_search_path

      expect(response).to be_successful
      data = JSON.parse(response.body, symbolize_names: true)

      expect(data.length).to eq(1)
      expect(data[:data].length).to eq(2)
      expect(data[:data]).to be_an(Array)
      expect(data[:data][:attributes].keys).to eq([:api_id, :name, :vintage, :region])
    end
    it "returns correct content" do
      get api_v1_wines_search_path

      expect(response).to be_successful
      data = JSON.parse(response.body, symbolize_names: true)

      
    end
  end
  # describe 'sad path' do
    # it '' do
    # end
  # end
end




# res = File.read('spec/fixtures/wines_search_results.json')
# out = JSON.parse(res)

# expect(res[:data].length).to eq(2)
