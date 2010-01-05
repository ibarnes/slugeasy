# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  #rescue_from ActiveRecord::RecordNotFound, :with => :not_found
  
  # Scrub sensitive parameters from your log
  filter_parameter_logging :password, :password_confirmation
  
  helper_method :current_user, :current_user_session, :current_user_plan
  
  private

  #def not_found(exception)
   #     "Sorry page not found"
  #end

	def current_user_session
		return @current_user_session if defined?(@current_user_session)
		@current_user_session = UserSession.find
	end

	def current_user
		return @current_user if defined?(@current_user)
		@current_user = current_user_session && current_user_session.record
	end

  def current_user_plan
    @order = Order.find_or_create_by_user_id(current_user.id)
    
      return @order.plancode
  end

def logged_in?
    current_user
  end

  def profile_owner?
    if logged_in?
      @profile = Profile.find(params[:id])
      @profile.user_id == current_user.id
    end
  end

  def authorize_profile_owner
    unless logged_in? && profile_owner?
      flash[:error] = "Unauthorized access"
      redirect_to root_url

    end
  end
  
    def require_user
      unless current_user
        store_location
        flash[:notice] = "You must be logged in to access this page"
        redirect_to new_user_session_url
        return false
      end
    end

    def require_no_user
      if current_user
        store_location
        flash[:notice] = "You must be logged out to access this page"
        redirect_to user_url( :current )
        return false
      end
    end
    
    def store_location
      session[:return_to] = request.request_uri
    end

    def clear_location
      session[:return_to] = nil
    end
	
    def redirect_back_or_default(default)
      redirect_to(session[:return_to] || default)
      session[:return_to] = nil
    end

    def upgrade_message(plan)
      if plan == 'Basic'
        'You are upgrading your Slugeasy account. Since you are upgrading
         to a pay account, we will need your secure credit card details so we can
         bill you $12/month for the new plan. The upgrade will be effective immediately.
          You\'ll have access to your new features today.'
      else
        'You are upgrading your Slugeasy account. Since you are upgrading
         to a pay account, we will need your secure credit card details so we can
         bill you $24/month for the new plan. The upgrade will be effective immediately.
          You\'ll have access to your new features today.'
      end
    end
end
