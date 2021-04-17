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
      expect(favorite_wine[:id]).to be_an(String)
      expect(favorite_wine[:id]).to eq(user_wine.id.to_s)
      expect(favorite_wine).to have_key(:type)
      expect(favorite_wine[:type]).to be_a(String)
      expect(favorite_wine[:type]).to eq('favorite_wine')
      expect(favorite_wine).to have_key(:attributes)
      expect(favorite_wine[:attributes]).to be_a(Hash)

      attributes = favorite_wine[:attributes]
      expect(attributes).to have_key(:api_id)
      expect(attributes[:api_id]).to be_a(String)
      expect(attributes[:api_id]).to eq(wine.api_id.to_s)
      expect(attributes).to have_key(:name)
      expect(attributes[:name]).to be_a(String)
      expect(attributes[:name]).to eq(wine.name)
      expect(attributes).to have_key(:comment)
      expect(attributes[:comment]).to be_a(String)
      expect(attributes[:comment]).to eq(user_wine.comment)
    end
  end

  describe 'sad path' do
    it 'returns empty data if user_id does not exist' do
      get api_v1_users_dashboard_path(-1)

      expect(response).to be_successful
      body = JSON.parse(response.body, symbolize_names: true)

      expect(body[:data]).to be_empty
    end
  end
end
