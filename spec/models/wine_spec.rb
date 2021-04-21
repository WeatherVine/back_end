require 'rails_helper'

RSpec.describe Wine, type: :model do
  describe 'relationships' do
    it { should have_many :user_wines }
  end

  describe 'validations' do
    it { should validate_uniqueness_of :api_id }
    it { should validate_presence_of :name }
    it { should validate_presence_of :api_id }
  end
end
