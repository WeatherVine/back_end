require 'rails_helper'

RSpec.describe Wine, type: :model do
  describe 'relationships' do
    it { should have_many :user_wines }
  end 
end
