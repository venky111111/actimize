class AddDescriptionToBaseAppSubFeatures < ActiveRecord::Migration[6.1]
  def change
    add_column :base_app_sub_features, :description, :string
  end
end
