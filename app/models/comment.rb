class Comment < ApplicationRecord

  #validates :comment_id, {absence: true}
  validates :message, {presence: true}
  validates :meal_id, {presence: true}
  validates :commenter, {presence: true}
  belongs_to :meal

  #belongs_to :commenter
  #belongs_to :user
  belongs_to :commenter, class_name: 'User', foreign_key: 'commenter'
  belongs_to :comment, class_name: "Comment", optional: true
  has_many :comments,  class_name: "Comment",foreign_key: "comment_id", dependent: :destroy



end
