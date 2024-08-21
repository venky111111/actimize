class CreateUserApps < ActiveRecord::Migration[6.1]
  def change
    create_table :user_apps do |t|
      t.string :name
      t.string :logo
      t.string :theme_color
      t.string :app_platform
      
      t.boolean :design
      t.boolean :basic_build
      t.boolean :full_build
      t.text :note
      t.string :budget
      t.string :payment_way
      t.boolean :support
      t.boolean :cloud
      t.boolean :market_place
      t.integer :user_id
      t.string :status
      t.string :stage
      t.string :coupon_code

      t.timestamps
    end
  end
end
