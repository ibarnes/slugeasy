class Profile < ActiveRecord::Base
  belongs_to :user

  validates_length_of :description, :maximum => 160
  
end
