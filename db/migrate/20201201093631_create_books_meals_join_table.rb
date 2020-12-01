class CreateBooksMealsJoinTable < ActiveRecord::Migration[6.0]
  def change
    create_join_table :books, :meals
  end
end
