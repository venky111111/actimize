class CreateUserAppSubFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :user_app_sub_features do |t|
      t.string :name
      t.integer :user_app_feature_id
      t.string :description

      t.timestamps
    end
  end
end
