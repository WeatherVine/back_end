FactoryBot.define do
  factory :user_wine do
    wine { nil }
    user_id { 1 }
    comment { "MyString" }
  end
end
