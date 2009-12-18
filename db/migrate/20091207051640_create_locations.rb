class CreateLocations < ActiveRecord::Migration
  def self.up
    create_table :locations do |t|
      t.string    :title
      t.integer   :to_location_id
      t.integer   :fr_location_id
      
      t.timestamps
    end
  end

  def self.down
    drop_table :locations
  end
end
