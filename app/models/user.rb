class User < ApplicationRecord
  validates :name, {presence: true}
  validates :email, {presence: true, uniqueness: true}
  #validates :password, {presence: true}
  has_secure_password

  #has_many :meals, :foreign_key => "user_id", dependent: :destroy
  has_many :meals, dependent: :destroy
  has_many :comments, through: :meals, dependent: :destroy
  has_many :commenters, through: :comments, dependent: :destroy
  #-> {includes :comments}

  #def meals
  #return Meal.where(user_id: self.id)
  #end

end
