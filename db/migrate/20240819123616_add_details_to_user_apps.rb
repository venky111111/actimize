class AddDetailsToUserApps < ActiveRecord::Migration[6.1]
  def change
    add_column :user_apps, :user_name, :string
    add_column :user_apps, :user_role, :string
    add_column :user_apps, :user_email, :string
    add_column :user_apps, :user_phone, :bigint
  end
end
