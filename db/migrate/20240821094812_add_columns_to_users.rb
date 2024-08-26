class AddColumnsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :email_verified, :boolean
    add_column :users, :mobile_verification, :boolean
    add_column :users, :type, :string
    add_column :users, :role, :string
    add_column :users, :accepted_terms_conditions, :boolean
  end
end
