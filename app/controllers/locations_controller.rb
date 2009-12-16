class LocationsController < ApplicationController
  # GET /locations
  # GET /locations.xml

  def index
	@locations = Location.find(:all, :conditions => ['title LIKE ?', "%#{params[:search]}%"], :order => 'title asc')

   # @locations = Location.all

    respond_to do |format|
    format.js	
   # format.html # index.html.erb
    
    #format.xml  { render :xml => @locations }
    end
  end
end
