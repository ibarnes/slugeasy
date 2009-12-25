class Order < ActiveRecord::Base
  attr_accessor :card_number
  attr_accessor :card_month
  attr_accessor :card_year
  attr_accessor :zip

  belongs_to :user

#  validate_on_create :validate_card
#
  validates_length_of :lastname, :firstname, :in=>1..20
  
#  validates_numericality_of :card_number
  validates_length_of :card_number, :is => 16, :on=>:create
  validates_presence_of :card_month,:card_year,:zip, :on=>:create
  validates_length_of :zip, :is=> 5, :on=>:create

  def create_order(order,user)
    @order = order
    @user = user
    @customer = Hash.new

    @customer={

      :code => @user.id.to_s + "." + @order.lastname, # required
      :firstName  => @order.firstname,     # required
      :lastName   => @order.lastname,      # required
      :email      => @user.email,          # required
      :company    => '',
      :subscription =>{
        :planCode     => @order.plancode,          # required
        :ccFirstName  => @order.firstname,        # required unless plan is free
        :ccLastName   => @order.lastname,         # required unless plan is free
        :ccNumber     => @order.card_number,  # required unless plan is free
        :ccExpiration => @order.card_month.to_s + "/" + @order.card_year.to_s,       # required unless plan is free
        :ccZip        => @order.zip  # required unless plan is free
      }
    }
    return @customer
  end

   def upgrade_order(order,oldplan)
    @order = order

    if oldplan == 'Basic'
      @order.plancode = 'Pro'
    end
    
    @customer = Hash.new

    @customer={
      :subscription =>{
        :planCode     => @order.plancode,          # required
        :ccFirstName  => @order.firstname,        # required unless plan is free
        :ccLastName   => @order.lastname,         # required unless plan is free
        :ccNumber     => @order.card_number,  # required unless plan is free
        :ccExpiration => @order.card_month.to_s + "/" + @order.card_year.to_s,       # required unless plan is free
        :ccZip        => @order.zip  # required unless plan is free
      }
    }
    return @customer
  end
  

  def validate_card
    unless card_valid?
      errors.add_to_base 'Card is invalid please check all the fields'
    end
  end
  
#  def card_valid?
#
#    unless self.card_number.size == 16
#      false
#    end
#    unless self.zip.size == 5
#      false
#    end
#  end
end
