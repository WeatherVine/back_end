require 'rails_helper'

RSpec.describe 'FactoryBot' do
  it 'creates good objects' do
    wine = create(:wine)
    user_wine = create(:user_wine)

    expect(wine).to be_a(Wine)
    expect(user_wine).to be_a(UserWine)
  end
end
