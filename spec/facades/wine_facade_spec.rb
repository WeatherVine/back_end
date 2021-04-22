require 'rails_helper'
require 'ostruct'

RSpec.describe WineFacade do
  describe 'happy path' do
    it 'calls the Facade search and returns the correct object with data' do
      VCR.use_cassette("wine_facade") do

        result = WineFacade.fetch_wine_info("5f065fb5fbfd6e17acaad294")

        expect(result).to be_an(OpenStruct)
        expect(result.api_id).to eq("5f065fb5fbfd6e17acaad294")
        expect(result.name).to eq("Duckhorn The Discussion Red 2012")
        expect(result.area).to eq("Napa Valley")
        expect(result.vintage).to eq("2012")
        expect(result.eye).to eq("Translucent rim, Translucent depth")
        expect(result.nose).to eq("Oak, Berry, Blackberry aromas")
        expect(result.mouth).to eq("Oak, Berry, Blackberry flavours, Flat sweetness, Flat acidity, Rich tannins, Warm alcohol")
        expect(result.finish).to eq("Medium duration, Good quality, Late peaktime")
        expect(result.overall).to eq("Subtle complexity, Memorable interest, Expected typicity, Harmonious balance")
      end
    end
  end
end
