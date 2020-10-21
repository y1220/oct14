class AddCommentIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :comment, index:true
  end
end
