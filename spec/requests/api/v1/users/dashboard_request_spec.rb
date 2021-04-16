require 'rails_helper'

RSpec.describe 'Dashboard Data Request' do
  describe 'happy path' do
    it 'endpoint exists' do
      wine = create(:wine)
      user_wine = create(:user_wine, user_id: 1, wine_id: wine.id)

      get api_v1_users_dashboard_path(1)

      expect(response).to be_successful

      body = JSON.parse(response.body, symbolize_names: true)

      expect(body).to have_key(:data)

      data = body[:data]

      expect(data).to be_an(Array)
      expect(data.size).to eq(1)

      favorite_wine = data[0]

      expect(favorite_wine).to have_key(:id)
      expect(favorite_wine[:id]).to be_an(Integer)
      expect(favorite_wine).to have_key(:name)
      expect(favorite_wine[:name])to be_a(String)
      expect(favorite_wine).to have_key(:attributes)
      expect(favorite_wine[:attributes]).to be_a(Hash)

      attributes = favorite_wine[:attributes]

      expect(attributes).to have_key(:api_id)
      expect(attributes[:api_id]).to be_a(String)
      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)
      expect(attributes).to have_key(:comment)
      expect(attributes[:comment]).to be_a(String)
    end
    # TODO: assert values as part of this test or in a new test.
  end
end
