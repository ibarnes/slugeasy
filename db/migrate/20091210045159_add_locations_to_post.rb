class AddLocationsToPost < ActiveRecord::Migration
  def self.up
    add_column :posts, :fr_location, :string, :length => 255
     add_column :posts, :to_location, :string, :length => 255
     add_column :posts, :time, :string, :length => 4
     remove_column :posts, :fr_location_id
    remove_column :posts, :to_location_id
  end

  def self.down
    remove_column :posts, :fr_location
    remove_column :posts, :to_location
  end
end
