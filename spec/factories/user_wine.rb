FactoryBot.define do
  factory :user_wine do
    sequence :user_id do |n|
      n
    end

    comment { Faker::Lorem.sentence }

    wine
  end
end
