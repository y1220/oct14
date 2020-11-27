class AddIndexToPdfs < ActiveRecord::Migration[6.0]
  def change
    add_index :requests, :pdfs, using: 'gin'
  end
end
