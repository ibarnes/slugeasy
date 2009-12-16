class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.integer    :user_id
      t.text      :listing
      t.string      :need
      t.string  :fr_location
      t.string  :to_location
      t.timestamps
    end
  end

  def self.down
    drop_table :posts
  end
end
