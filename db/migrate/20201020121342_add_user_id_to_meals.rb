class AddUserIdToMeals < ActiveRecord::Migration[5.2]
  def change
    add_reference :meals, :users, index:true
  end
end
