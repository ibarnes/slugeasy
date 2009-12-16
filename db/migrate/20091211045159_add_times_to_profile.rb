class AddTimesToProfile < ActiveRecord::Migration
  def self.up

     add_column :profiles, :start_time, :string, :length => 255
     add_column :profiles, :end_time, :string, :length => 255
  end

  def self.down
    remove_column :posts, :start_time
    remove_column :posts, :end_time
  end
end