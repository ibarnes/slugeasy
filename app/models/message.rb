class Message < ActiveRecord::Base
 cattr_reader :per_page
  @per_page = 20
  belongs_to :user
 has_many :comments
  validates_presence_of :body
  validates_length_of :body, :within=> 20..160
  
end
