class Meal < ApplicationRecord
  validates :content, {presence: true, length: {maximum: 100}}
  validates :user_id, {presence: true}
  validates :title, {presence: true}
  validates :meal_type, {presence: true}

  def user
    return User.find_by(id: self.user_id)
  end
end
