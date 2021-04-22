require 'rails_helper'

RSpec.describe 'the wine show request' do
  describe 'happy path' do
    it 'returns correct structure' do
      VCR.use_cassette("wine_weather_data") do
        @wine = create(:wine, api_id: '546e64cf4c6458020000000d', name: 'Duckhorn Sauvignon Blanc')

        get api_v1_wine_path(id: @wine.api_id)

        expect(response).to be_successful
        result = JSON.parse(response.body, symbolize_names: true)

        expect(result.length).to eq(1)
        expect(result[:data]).to be_a(Hash)

        data = result[:data]
        expect(data.keys).to eq([:id, :type, :attributes])
        expect(data[:attributes]).to be_a(Hash)

        wine = data[:attributes]
        expect(wine.keys).to eq(wine_weather_attribute_keys)
      end
    end

    it 'returns correct content' do
      VCR.use_cassette("wine_weather_data") do
        @wine = create(:wine, api_id: '546e64cf4c6458020000000d', name: 'Duckhorn Sauvignon Blanc')

        get api_v1_wine_path(id: @wine.api_id)

        expect(response).to be_successful
        result = JSON.parse(response.body, symbolize_names: true)

        data = result[:data]
        expect(data[:id]).to eq(nil)
        expect(data[:type]).to eq('wine_weather')

        wine = data[:attributes]
        expect(wine[:api_id]).to eq('546e64cf4c6458020000000d')
        expect(wine[:name]).to eq('Duckhorn')
        expect(wine[:area]).to eq('Napa Valley')
        expect(wine[:vintage]).to eq('2013')
        expect(wine[:eye]).to eq('')
        expect(wine[:nose]).to eq('Citrus, Earthy aromas')
        expect(wine[:mouth]).to eq('Citrus, Earthy flavours, Fresh acidity, Warm alcohol')
        expect(wine[:finish]).to eq('Medium duration, Good quality, Middle peaktime')
        expect(wine[:overall]).to eq('Subtle complexity, Pleasant interest, Harmonious balance')
        expect(wine[:temp]).to eq(81)
        expect(wine[:precip]).to eq(79.0)
        expect(wine[:start_date]).to eq('2012-01-01')
        expect(wine[:end_date]).to eq('2012-12-31')
      end
    end
  end

  def wine_weather_attribute_keys
    [
      :api_id,
      :name,
      :area,
      :vintage,
      :eye,
      :nose,
      :mouth,
      :finish,
      :overall,
      :temp,
      :precip,
      :start_date,
      :end_date
    ]
  end
end
