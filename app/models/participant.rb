class Participant < ApplicationRecord
  validates :course_id, uniqueness: { scope: :user_id }
  belongs_to :course
  belongs_to :user
end
