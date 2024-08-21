class CreateUserAppDocuments < ActiveRecord::Migration[6.1]
  def change
    create_table :user_app_documents do |t|
      t.string :user_app_file_name
      t.string :user_app_file_type
      t.string :user_app_file_data
      t.integer :user_app_id

      t.timestamps
    end
  end
end
