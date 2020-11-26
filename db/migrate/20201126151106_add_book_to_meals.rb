class AddBookToMeals < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :book, :boolean, :default=> false
  end
end
