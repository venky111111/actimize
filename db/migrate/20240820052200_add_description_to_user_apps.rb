class AddDescriptionToUserApps < ActiveRecord::Migration[6.1]
  def change
    add_column :user_apps, :description, :string
  end
end
