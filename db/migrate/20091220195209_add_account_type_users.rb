class AddAccountTypeUsers < ActiveRecord::Migration
  def self.up
  
    add_column :users, :account_type, :string
  end

  def self.down

    remove_column :users, :account_type
  end
end
