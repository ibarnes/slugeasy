class UsersController < ApplicationController
	before_filter :require_no_user, :only => [:new, :create]
	before_filter :require_user, :except => [:new, :create, :upgrade, :pro,:basic]

  def new
    @user = User.new
    @order = Order.new
    @paid = false
    @plan = "Free"
  end

  def basic
    @user = User.new
    @order = Order.new
    @paid=true
    @plan="Basic"
  end

  def pro
    @user = User.new
    @order = Order.new
    @paid=true
    @plan="Pro"
  end

  def upgrade
    #@user = User.new
  end

  def create
    @user = User.new(params[:user])
    @order = Order.new(params[:order])
    
    @cheddar_getter = CheddarGetter.new('ikebarnes@gmail.com', '135adgzc', '135adgzc')

    begin
      @customer = @order.create_order(@order,@user)
       @cheddar_getter.create_customer(@customer)

      if @order.save

        if @user.save
          @profile = Profile.new(:user_id=>@user.id, :description=>'')
          #@user.create_profile(:description=>'')
          if @profile.save
            flash[:notice] = "You have successfully created your " + @order.plancode + " account."
            redirect_to show_user_url(@user.username)
          end
        else # If user did not save send them back to register
          plan_render(@order)
        end
      else #If order did not save send them back to register
      
       plan_render(@order)
      
      end
    rescue CheddarGetter::Error => e
      if e.message == 'A value is required'
        flash[:warning] = 'Please complete the entire form.'
      else
        flash[:warning] = e.message
      end

      
     plan_render(@order)
    end
  end

  def edit
    @user = current_user
    @user.valid?
  end

  def show
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    @user.attributes = params[:user]
    if @user.save
      flash[:notice] = "Successfully updated user."
      redirect_back_or_default articles_path
    else
      render :action => 'edit'
    end
  end

	# This action has the special purpose of receiving an update of the RPX identity information
	# for current user - to add RPX authentication to an existing non-RPX account.
	# RPX only supports :post, so this cannot simply go to update method (:put)
	def addrpxauth
		@user = current_user
		if @user.save
			flash[:notice] = "Successfully added RPX authentication for this account."
			render :action => 'show'
		else
			render :action => 'edit'
		end
	end

  def plan_render(order)
    @order = order
    if @order.plancode == "Pro"
            @paid = true
            @plan = @order.plancode
            render  :action=>'pro'
          elsif @order.plancode == "Basic"
            @paid = true
            @plan = @order.plancode
            render  :action=>'basic'
          end
  end
  
end
