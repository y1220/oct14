class AddNonNullToCourse < ActiveRecord::Migration[6.0]
  def change
    change_column_null :courses, :name, false
    change_column_null :courses, :description, false
    change_column_null :courses, :price, false
  end
end
