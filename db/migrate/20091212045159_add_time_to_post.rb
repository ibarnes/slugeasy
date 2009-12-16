class AddTimeToPost < ActiveRecord::Migration
  def self.up

     add_column :posts, :time, :string, :length => 255

  end

  def self.down
    remove_column :posts, :time

  end
end