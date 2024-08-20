class CreateBaseAppSubFeatures < ActiveRecord::Migration[6.1]
  def change
    create_table :base_app_sub_features do |t|
      t.string :name
      t.integer :baseappfeature_id

      t.timestamps
    end
  end
end
