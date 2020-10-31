FactoryBot.define do
  factory :meal do
    title {'test title PIZZA'}
    content {'test content DELICIOUS PIZZA'}
    meal_type {1}
    user
  end
end
