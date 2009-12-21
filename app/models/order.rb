class Order < ActiveRecord::Base
attr_accessor :card_number
attr_accessor :card_expiration, :datetime
attr_accessor :zip
  @cheddar_getter = CheddarGetter.new('ikebarnes@gmail.com', '135adgzc', '135adgzc')


end
