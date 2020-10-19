class ModifyColumnNameToTitle < ActiveRecord::Migration[5.2]
  def change
    rename_column :meals, :name, :title
  end
end
