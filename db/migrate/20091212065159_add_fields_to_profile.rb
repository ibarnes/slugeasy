class AddFieldsToProfile < ActiveRecord::Migration
  def self.up

     add_column :profiles, :music_preference, :integer
     add_column :profiles, :job_location, :string
     add_column :profiles, :noise_preference, :integer
     
  end

  def self.down
    remove_column :profiles, :music_preference
    remove_column :profiles, :noise_preference
    remove_column :profiles, :job_location
  end
end