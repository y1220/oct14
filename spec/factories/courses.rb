FactoryBot.define do
  factory :course do
    user { nil }
    name { "MyString" }
    description { "MyText" }
    price { 1 }
  end
end
