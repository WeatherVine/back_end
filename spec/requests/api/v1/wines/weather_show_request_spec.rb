require 'rails_helper'

RSpec.describe 'the weather show request' do
  describe 'happy path' do
    it 'returns correct structure' do
      expected_raw = File.read('spec/fixtures/weather_show_results.json')
    end
  end
end
