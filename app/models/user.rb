

class User < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  #validates :password, {presence: true}
  has_secure_password

  has_many :meals, :foreign_key => "user_id", dependent: :destroy



  def meals
    return Meal.where(user_id: self.id)
  end

end
