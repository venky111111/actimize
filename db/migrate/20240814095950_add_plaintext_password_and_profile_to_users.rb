class AddPlaintextPasswordAndProfileToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :plaintext_password, :string
    add_column :users, :profile, :string
  end
end
