require 'rails_helper'

RSpec.describe UserWine, type: :model do
  describe 'relationships' do
    it { should belong_to :wine }
  end
end
