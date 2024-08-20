class CreateBaseAppFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :base_app_features do |t|
      t.string :name
      t.integer :base_app_id

      t.timestamps
    end
  end
end
