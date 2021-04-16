require 'rails_helper'

RSpec.describe 'Dashboard Data Request' do
  describe 'happy path' do
    it 'response has correct format' do
      wine = create(:wine)
      user_wine = create(:user_wine, user_id: 1, wine_id: wine.id)

      get api_v1_users_dashboard_path(1)
    end
  end
end
