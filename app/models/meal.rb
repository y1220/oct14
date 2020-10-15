class Meal < ApplicationRecord
  validates :user_id, {presence: true}
end
