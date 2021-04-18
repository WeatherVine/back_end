require 'rails_helper'

RSpec.describe 'the wine show request' do
  describe 'happy path' do
    it 'returns correct structure' do
      expected_raw = File.read('spec/fixtures/wine_show_page_results.json')
      expected = JSON.parse!(expected_raw, symbolize_names: true)

      stub_microservice_request(expected)

      get api_v1_wine_path(id: @wine.api_id)

      expect(response).to be_successful
      result = JSON.parse(response.body, symbolize_names: true)

      expect(result.length).to eq(1)
      expect(result[:data]).to be_a(Hash)

      data = result[:data]
      expect(data[:keys]).to eq([:id, :type, :attributes])
      expect(data[:attributes]).to be_a(Hash)

      wine = data[:attributes]
      expect(wine.keys).to eq(wine_attribute_keys)
    end

    xit 'returns correct content' do
      expected_raw = File.read('spec/fixtures/wine_show_page_results.json')
      expected = JSON.parse!(expected_raw, symbolize_names: true)

      stub_microservice_request(expected)

      get api_v1_wine_path(id: @wine.api_id)

      expect(response).to be_successful
      result = JSON.parse(response.body, symbolize_names: true)

      data = result[:data]
      expect(data[:id]).to eq(nil)
      expect(data[:type]).to eq('Wine')

      wine = data[:attributes]
      expect(wine[:id]).to eq(nil)
      expect(wine[:api_id]).to eq('546e64cf4c6458020000000d')
      expect(wine[:name]).to eq('Duckhorn Sauvignon Blanc')
      expect(wine[:winery]).to eq('Duckhorn Vineyards')
      expect(wine[:vintage]).to eq('2018')
      expect(wine[:country]).to eq('USA')
      expect(wine[:area]).to eq('Napa Valley')
      expect(wine[:style]).to eq('')
      expect(wine[:varietal]).to eq('Sauvignon Blanc')
      expect(wine[:type]).to eq('White')
      expect(wine[:eye]).to eq('')
      expect(wine[:nose]).to eq('Citrus, Earthy aromas')
      expect(wine[:mouth]).to eq('Citrus, Earthy flavours, Fresh acidity, Warm alcohol')
      expect(wine[:finish]).to eq('Medium duration, Good quality, Middle peaktime')
      expect(wine[:overall]).to eq('Subtle complexity, Pleasant interest, Harmonious balance')
    end
  end

  def stub_microservice_request(body)
    @wine = create(:wine, api_id: '546e64cf4c6458020000000d', name: 'Duckhorn Sauvignon Blanc')

    full_url = "#{ENV['WINE_MICROSERVICE_URL']}/wine/#{@wine.api_id}"
    stub_request(:get, full_url)
      .to_return(
        status: 200,
        body: body.to_json,
        headers: {'Content-Type'=> 'application/json'}
      )
  end

  def wine_attribute_keys
    [
      :id,
      :api_id,
      :name,
      :winery,
      :vintage,
      :country,
      :area,
      :style,
      :varietal,
      :type,
      :eye,
      :nose,
      :mouth,
      :finish,
      :overall
    ]
  end
end
