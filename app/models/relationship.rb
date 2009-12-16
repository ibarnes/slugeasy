class Relationship < ActiveRecord::Base
  belongs_to :user
  belongs_to :follower, :class_name => 'User'
  validates_uniqueness_of :follower_id, :scope => :user_id
  validates_presence_of :user_id, :follower_id
end
