class AddUserTypeAndAppIdToUserApps < ActiveRecord::Migration[6.1]
  def change
    add_column :user_apps, :user_type, :string
    add_column :user_apps, :app_id, :integer
  end
end
