class UserSessionsController < ApplicationController
	before_filter :require_user, :except => [:index, :new, :create]

	def index
		# this is where RPX will return to if the user cancelled the login process
		redirect_to current_user ? root_url : new_user_session_url
	end
	
	def new
		@user_session = UserSession.new
	end
  
	# Main method to create a user session and perform the authentication (password or RPX)
	#
	# this is fairly naively laid out, but basically showing some of the actions you might take
	# after creating a session (which may have involed user auto_registration via RPX) e.g.
	#  - if a new registration, force them to go via a registration follow-up page
	#  - if registration details not complete, bounce the user over the profile editing page
	#
	def create
		@user_session = UserSession.new(params[:user_session])
		if @user_session.save
			if @user_session.new_registration?
        @profile = Profile.new(:user_id=>@user.id)
        @profile.save
				flash[:notice] = "Welcome! As a new user, please review your registration details before continuing.."
				redirect_to show_user_path(current_user.username)
			else
				if @user_session.registration_complete?
					flash[:notice] = "Successfully signed in."
					redirect_back_or_default posts_path
				else
					flash[:notice] = "Welcome back " + current_user.username + "!"
					redirect_to show_user_path(current_user.username)
				end
			end
		else
			flash[:error] = "Failed to login or register."
			redirect_to new_user_session_path
		end
	end
  
	def destroy
		@user_session = current_user_session
		@user_session.destroy if @user_session
		flash[:notice] = "Successfully signed out."
		redirect_to posts_path
	end
	
end
