class RenameColumnsInUserApps < ActiveRecord::Migration[6.1]
  def change
    rename_column :user_apps, :app_id, :base_app
    rename_column :user_apps, :name, :application_name
    rename_column :user_apps, :stage, :step
  end
end
