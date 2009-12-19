class AddFieldsToProfile < ActiveRecord::Migration
  def self.up

     add_column :comments, :message_id, :integer
     remove_column :comments, :article_id
     
  end

  def self.down
    remove_column :comments, :message_id 
  end
end