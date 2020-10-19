class AddTypeToMeals < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :meal_type, :integer
  end
end
