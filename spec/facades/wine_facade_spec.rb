require 'rails_helper'
require 'ostruct'

RSpec.describe WineFacade do
  describe 'happy path' do
    it 'calls the Facade search and returns the correct object with data' do
      response = File.read('spec/fixtures/wine_show_page_results.json')
      expected = JSON.parse!(response, symoblize_names: true)

      stub_microservice_request(expected)

      result = WineFacade.fetch_wine_info("5f065fb5fbfd6e17acaad294")

      expect(result).to be_an(OpenStruct)
      # expect(result).to have_key(:api_id)
    end
  end

  def stub_microservice_request(body)
    full_url = "#{ENV['WINE_MICROSERVICE_URL']}/api/v1/wine-single?id=5f065fb5fbfd6e17acaad294"
    stub_request(:get, full_url)
    .to_return(
      status: 200,
      body: body.to_json,
      headers: {'Content-Type'=> 'application/json'}
    )
  end
end
