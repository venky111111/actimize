class AddDescriptionToBaseApps < ActiveRecord::Migration[6.1]
  def change
    add_column :base_apps, :description, :string
  end
end
