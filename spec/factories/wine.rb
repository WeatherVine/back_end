FactoryBot.define do
  factory :wine do
    sequence :api_id do |n|
      n
    end
    
    name { Faker::Beer.name }
  end
end
