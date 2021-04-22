class ClimateService
  # Report = Struct.new(:precip)
  #
  # def initialize( options={})
  #   @cache = options.fetch(:cache) { {} }
  # end
  # def get_climate_data(vintage, region)
  #   api_key = ENV['WEATHER_MICROSERVICE_URL']
  #   url = "#{api_key}/climate_data?vintage=#{vintage}&region=#{region}"
  #   body = @cache.fetch(vintage, region) {
  #     @cache[vintage, region] = open(url).read
  #   }
  #   data = JSON.parse(body)
  #   Report.new(data['precip']['temp'])
  # end
end

# Rails Guides example to work from for expiration
# class Product < ApplicationRecord
#   def competing_price
#     Rails.cache.fetch("#{cache_key_with_version}/competing_price", expires_in: 12.hours) do
#       Competitor::API.find_price(id)
#     end
#   end
# end
