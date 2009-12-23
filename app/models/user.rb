class User < ActiveRecord::Base
  is_gravtastic! :size => 40
	acts_as_authentic do |c|
		#c.map_id = false
	end
	attr_accessible :username, :email, :password, :password_confirmation, :rpx_identifier

	validates_uniqueness_of   :username, :case_sensitive => false

  #has_friendly_id
  has_friendly_id :username, :use_slug => true
  
  has_many :relationships
  has_many :followers, :through => :relationships
  has_many :inverse_relationships, :class_name => "Relationship", :foreign_key => "follower_id"
  has_many :inverse_followers, :through => :inverse_relationships, :source => :user
  has_many :posts
  has_many :messages_recieved, :class_name => "Message", :foreign_key => "receiver_id"
  has_many :messages, :foreign_key => 'sender_id'
  has_one :profile, :dependent => :destroy
  has_one :order,  :dependent => :destroy


  
  def add_friend(friend)
    friendship = relationships.build(:follower_id => friend.id)
    if !friendship.save
      logger.debug "User '#{friend.username}' already exists in the user's friendship list."
    end
  end

  
  
private

	# map_added_rpx_data maps additional fields from the RPX response into the user object during the "add RPX to existing account" process.
	# Override this in your user model to perform field mapping as may be desired
	# See https://rpxnow.com/docs#profile_data for the definition of available attributes
	#
	# By default, it only maps the rpx_identifier field.
	#
	def map_added_rpx_data( rpx_data )
		self.rpx_identifier = rpx_data['profile']['identifier']

		# map some additional fields, e.g. photo_url
		self.photo_url = rpx_data['profile']['photo'] if photo_url.blank?
	end
			
end
