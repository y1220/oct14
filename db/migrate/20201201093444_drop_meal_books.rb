class DropMealBooks < ActiveRecord::Migration[6.0]
  def change
    drop_table :meal_books
  end
end
