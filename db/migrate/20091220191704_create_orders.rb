class CreateOrders < ActiveRecord::Migration
  def self.up
    create_table :orders do |t|
      t.integer :user_id
      t.string :plancode
      t.string :firstname
      t.string :lastname

      t.timestamps
    end
  end

  def self.down
    drop_table :orders
  end
end
