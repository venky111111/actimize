class AddSelectedToBaseAppSubFeatures < ActiveRecord::Migration[6.1]
  def change
    add_column :base_app_sub_features, :selected, :boolean
  end
end
