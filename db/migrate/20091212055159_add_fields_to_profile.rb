class AddFieldsToProfile < ActiveRecord::Migration
  def self.up

     add_column :profiles, :music_preference, :integer
     add_column :profiles, :job_location, :string
     
  end

  def self.down
    remove_column :profiles, :music_preference
    remove_column :profiles, :job_location
  end
end