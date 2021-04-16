FactoryBot.define do
  factory :user_wine do
    wine
    
    sequence :user_id do |n|
      n
    end

    comment { Faker::Lorem.sentence }
  end
end
