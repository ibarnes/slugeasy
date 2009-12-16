class Message < ActiveRecord::Base
 belongs_to :user
  validates_presence_of :body
  validates_length_of :body, :within=> 20..160
  
end
