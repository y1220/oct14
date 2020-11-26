class MealBook < ApplicationRecord
  belongs_to :meal
  belongs_to :book
end
