class RemovePdfsFromRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :requests, :pdfs
  end
end
