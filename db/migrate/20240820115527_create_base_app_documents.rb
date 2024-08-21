class CreateBaseAppDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :base_app_documents do |t|
      t.string :base_app_file_name
      t.string :base_app_file_type
      t.string :base_app_file_data
      t.integer :base_app_id

      t.timestamps
    end
  end
end
