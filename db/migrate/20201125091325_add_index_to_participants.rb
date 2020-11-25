class AddIndexToParticipants < ActiveRecord::Migration[6.0]
  def change
    add_index :participants, [:user_id, :course_id], unique: true
  end
end
