class AddImageToMeals < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :image, :string
  end
end
