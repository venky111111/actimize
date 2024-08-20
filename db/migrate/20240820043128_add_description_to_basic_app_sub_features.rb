class AddDescriptionToBasicAppSubFeatures < ActiveRecord::Migration[6.1]
  def change
    add_column :basic_app_sub_features, :description, :text
  end
end
