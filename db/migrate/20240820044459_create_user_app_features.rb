class CreateUserAppFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :user_app_features do |t|
      t.string :name
      t.integer :user_app_id

      t.timestamps
    end
  end
end
