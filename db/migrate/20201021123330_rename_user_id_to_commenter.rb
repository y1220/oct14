class RenameUserIdToCommenter < ActiveRecord::Migration[5.2]
  def change
    rename_column :comments, :user_id, :commenter
  end
end
