class AddPdfsToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :pdfs, :integer, array: true, default: '{}'
  end
end
