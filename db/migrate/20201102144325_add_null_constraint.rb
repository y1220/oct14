class AddNullConstraint < ActiveRecord::Migration[5.2]
  def change
    change_column_null(:users, :name, false)
    change_column_null(:users, :email, false)
    change_column_null(:users, :password_digest, false)
    change_column_null(:meals, :title, false)
    change_column_null(:meals, :content, false)
    change_column_null(:meals, :meal_type, false)
    change_column_null(:meals, :user_id, false)
    change_column_null(:comments, :meal_id, false)
    change_column_null(:comments, :message, false)
    change_column_null(:comments, :commenter, false)
    change_column_null(:meal_types, :description, false)
  end

end
