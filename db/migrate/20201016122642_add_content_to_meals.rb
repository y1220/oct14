class AddContentToMeals < ActiveRecord::Migration[5.2]
  def change
    add_column :meals, :content, :string
  end
end
