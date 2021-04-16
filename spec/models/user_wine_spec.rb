require 'rails_helper'

RSpec.describe UserWine, type: :model do
  describe 'relationships' do
    it { should belong_to :wine }
  end

  describe 'validations' do
    it { should validate_presence_of :user_id }
  end
end
