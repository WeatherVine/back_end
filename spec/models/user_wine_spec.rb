require 'rails_helper'

RSpec.describe UserWine, type: :model do
  describe 'relationships' do
    it { should belong_to :wine }
  end

  describe 'validations' do
    it { should validate_presence_of :user_id }
  end

  describe 'class methods' do
    describe '::for_user_dashboard' do
      it 'displays wines for that user' do
        user1_id = 1
        user2_id = 2
        wine1 = create(:wine, name: 'A Wine')
        wine2 = create(:wine, name: 'B Wine')
        uw1 = create(:user_wine, user_id: user1_id, wine_id: wine1.id)
        uw2 = create(:user_wine, user_id: user1_id, wine_id: wine2.id)
        uw3 = create(:user_wine, user_id: user2_id)

        result = UserWine.for_user_dashboard(user1_id)
        first = result.first
        second = result.second

        expect(first.id).to eq(uw1.id)
        expect(first.api_id).to eq(wine1.api_id)
        expect(first.name).to eq(wine1.name)
        expect(first.comment).to eq(uw1.comment)

        expect(second.id).to eq(uw2.id)
        expect(second.api_id).to eq(wine2.api_id)
        expect(second.name).to eq(wine2.name)
        expect(second.comment).to eq(uw2.comment)
      end
    end
  end
end
