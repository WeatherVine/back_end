require 'rails_helper'
require 'ostruct'

RSpec.describe WineService do
  describe 'happy path' do
    it 'fetches wine data and returns the correct object' do
      VCR.use_cassette("wine_microservice_fetch") do

        response = WineService.fetch_wine("5f065fb5fbfd6e17acaad294")

        expect(response).to be_an(OpenStruct)
        expect(response).to respond_to("api_id")
        expect(response).to respond_to("name")
        expect(response).to respond_to("area")
        expect(response).to respond_to("vintage")
        expect(response).to respond_to("eye")
        expect(response).to respond_to("nose")
        expect(response).to respond_to("mouth")
        expect(response).to respond_to("finish")
        expect(response).to respond_to("overall")
      end
    end

    it 'can test the data structure of the API data received from the call' do
      VCR.use_cassette("wine_microservice_fetch") do
        response = WineService.fetch_wine("5f065fb5fbfd6e17acaad294")

        expect(response.api_id).to eq("5f065fb5fbfd6e17acaad294")
        expect(response.name).to eq("Duckhorn The Discussion Red 2012")
        expect(response.area).to eq("Napa Valley")
        expect(response.vintage).to eq("2012")
        expect(response.eye).to eq("Translucent rim, Translucent depth")
        expect(response.nose).to eq("Oak, Berry, Blackberry aromas")
        expect(response.mouth).to eq("Oak, Berry, Blackberry flavours, Flat sweetness, Flat acidity, Rich tannins, Warm alcohol")
        expect(response.finish).to eq("Medium duration, Good quality, Late peaktime")
        expect(response.overall).to eq("Subtle complexity, Memorable interest, Expected typicity, Harmonious balance")
      end
    end
  end
end
