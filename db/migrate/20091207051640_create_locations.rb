class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string    :title
      t.string   :to_location
      t.string   :fr_location
      t.string   :time, :length => 5
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
