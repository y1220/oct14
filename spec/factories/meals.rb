FactoryBot.define do
  cnt1=0
  factory :meal do
    title {"Pizza#{cnt1}"}
    content {'Delicious Pizza'}
    meal_type {cnt1%7}
    user
    cnt1+= 1
  end

end
