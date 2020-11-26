class CreateMealBooks < ActiveRecord::Migration[6.0]
  def change
    create_table :meal_books do |t|
      t.references :meal, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end
