class Course < ApplicationRecord
  validates :name, {presence: true}
  validates :description, {presence: true}
  validates :price, {presence: true}
  belongs_to :user
  has_many :participants, dependent: :destroy
end
