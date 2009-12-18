class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer    :user_id
      t.text      :listing
      t.string      :need
      t.integer  :fr_location_id
      t.integer :to_location_id
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
