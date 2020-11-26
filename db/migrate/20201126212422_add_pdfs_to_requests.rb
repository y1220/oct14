class AddPdfsToRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :requests, :pdfs, :text, default: [].to_yaml
  end
end
