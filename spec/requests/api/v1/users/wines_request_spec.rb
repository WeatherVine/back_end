require 'rails_helper'

RSpec.describe 'User Wine Create API' do
  describe 'happy path' do
    before :each do
      create(:wine, api_id: "api1", name: "wine 1")
      @wine1 = Wine.first

      user_wine_params = ({wine_id: "api2",
                wine_name: "wine 2",
                user_id: 1,
                comment: "this is a comment for user wine creation."})

      headers = {"CONTENT_TYPE" => "application/json"}

      post api_v1_users_wines_path(1), headers: headers, params: JSON.generate(user_wine: user_wine_params)

      parsed = JSON.parse(response.body, symbolize_names: true)
      @data = parsed[:data]
      @created_wine = Wine.where(api_id: "api2").first
      @created_user_wine = UserWine.where(wine_id: @created_wine.id, user_id: 1).first
    end

    it 'endpoint exists' do

      expect(response).to be_successful
    end


    it 'creates a wine in the database if there isnt one already' do

      expect(@created_wine.api_id).to eq("api2")
      expect(@created_wine.name).to eq("wine 2")
    end

    it 'can create a new user wine' do
      
      expect(@created_user_wine).to_not be_nil
      expect(@created_user_wine.wine_id).to eq(@created_wine.id)
      expect(@created_user_wine.user_id).to eq(1)
      expect(@created_user_wine.comment).to eq("this is a comment for user wine creation.")
    end

    it 'displays the right JSON output' do

      expect(@data).to have_key(:id)
      expect(@data).to have_key(:type)
      expect(@data).to have_key(:attributes)

      expect(@data[:type]).to eq("user_wine")

      expect(@data[:attributes][:wine_id]).to eq(@created_wine.id)
      expect(@data[:attributes][:user_id]).to eq(1)
      expect(@data[:attributes][:comment]).to eq("this is a comment for user wine creation.")
    end
  end

  describe 'sad path' do

    it 'does not duplicate a wine if its already in the database' do
      create(:wine, api_id: "api1", name: "wine 1")
      expect(Wine.all.length).to eq(1)
      @wine = Wine.first
      headers = {"CONTENT_TYPE" => "application/json"}
      post api_v1_users_wines_path(1), headers: headers, params: JSON.generate(user_wine: {wine_id: "api1", wine_name: "wine 1", user_id: 1, comment: "This should not create a new wine, but should show in the user wine."})
      @user_wine = UserWine.where(wine_id: @wine.id, user_id: 1).first

      expect(Wine.all.length).to eq(1)
      expect(@user_wine.wine_id).to eq(@wine.id)
      expect(@user_wine.user_id).to eq(1)
      expect(@user_wine.comment).to eq("This should not create a new wine, but should show in the user wine.")
    end
  end
end