class Comment < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
  attr_accessible :description

  validates_length_of :description, :maximum => 160
  validates_presence_of :description
end
