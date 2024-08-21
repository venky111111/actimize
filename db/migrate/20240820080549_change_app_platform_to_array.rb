class ChangeAppPlatformToArray < ActiveRecord::Migration[6.1]
  def change
    def up
    # Convert existing string data to array data
    execute <<-SQL
      ALTER TABLE user_apps
      ALTER COLUMN app_platform
      TYPE text[] USING string_to_array(app_platform, ',');
    SQL

    # Change the column type to array
    change_column :user_apps, :app_platform, :text, array: true, default: []
  end

  def down
    # Convert the array data back to string
    execute <<-SQL
      ALTER TABLE user_apps
      ALTER COLUMN app_platform
      TYPE varchar USING array_to_string(app_platform, ',');
    SQL

    # Change the column type back to string
    change_column :user_apps, :app_platform, :string, default: ''
  end
  end
end
