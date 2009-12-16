class Post < ActiveRecord::Base
  cattr_reader :per_page
  @per_page = 20

  belongs_to :user
  belongs_to :location
  
  validates_presence_of :user_id,:time,:need,:fr_location,:to_location
 # has_friendly_id :title, :use_slug => true
  
  def location_title
    location.title if location
  end

  def location_title=(title)
    self.location = Location.find_or_create_by_title(title) unless title.blank?
  end

end
