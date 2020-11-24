class AddStarToMeal < ActiveRecord::Migration[6.0]
  def change
    add_column :meals, :star, :boolean, :default=> false
  end
end
