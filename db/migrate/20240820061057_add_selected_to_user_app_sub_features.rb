class AddSelectedToUserAppSubFeatures < ActiveRecord::Migration[6.1]
  def change
    add_column :user_app_sub_features, :selected, :boolean
  end
end
