require 'rails_helper'

RSpec.describe 'User Wine Create API' do
  before :each do
    create_list(:wine, 5)
    @wine1 = Wine.first

    user_wine_params = ({wine_id: @wine1.id,
              user_id: 1,
              comment: "this is a comment for user wine creation."})

    headers = {"CONTENT_TYPE" => "application/json"}

    post api_v1_users_wines_path(1), headers: headers, params: JSON.generate(user_wine: user_wine_params)

    parsed = JSON.parse(response.body, symbolize_names: true)
    @data = parsed[:data]

    @created_user_wine = UserWine.where(wine_id: @wine1.id, user_id: 1).first
  end

  it 'endpoint exists' do

    expect(response).to be_successful
  end

  it 'can create a new user wine' do
    
    expect(@created_user_wine).to_not be_nil
    expect(@created_user_wine.wine_id).to eq(@wine1.id)
    expect(@created_user_wine.user_id).to eq(1)
    expect(@created_user_wine.comment).to eq("this is a comment for user wine creation.")
  end

  it 'displays the right JSON output' do

    expect(@data).to have_key(:id)
    expect(@data).to have_key(:type)
    expect(@data).to have_key(:attributes)

    expect(@data[:type]).to eq("user_wine")

    expect(@data[:attributes][:wine_id]).to eq(@wine1.id)
    expect(@data[:attributes][:user_id]).to eq(1)
    expect(@data[:attributes][:comment]).to eq("this is a comment for user wine creation.")
  end
end