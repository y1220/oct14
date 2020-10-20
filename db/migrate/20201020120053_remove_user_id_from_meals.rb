class RemoveUserIdFromMeals < ActiveRecord::Migration[5.2]
  def change
    remove_column :meals, :user_id
  end
end
