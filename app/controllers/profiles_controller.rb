class ProfilesController < ApplicationController
before_filter :authorize_profile_owner, :only => :edit
  # GET /profiles
  # GET /profiles.xml
  def index
    @profiles = Profile.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @profiles }
    end
  end

  def follow
    # Insert the current_user id into the follower_id column of the relationship table
    # Insert the user_id of the currently viewed profile into the user_id column
    @follow = Relationship.new
    @follow.user_id = params[:id]
    @follow.follower_id = current_user.id
    if @follow.save
      flash[:notice] = "Following!"
      redirect_to(root_url)
    end
  end


  # GET /profiles/1
  # GET /profiles/1.xml
  def show
    
    #@user = User.find_by_username(params[:slug])
    @post = Post.new
    @user =
    @profile = Profile.find_by_user_id(User.find_by_username(params[:slug]).id)
    @user = User.find(@profile.user_id)
    if current_user == @user
      @posts = Post.paginate_all_by_user_id(@user.followers.map(& :id).push(@user.id), :page => params[:page], :per_page => 10, :order=>'created_at desc')
    else
      @posts = Post.paginate_all_by_user_id(@user.id, :page => params[:page], :per_page => 10, :order=>'created_at desc')
    end

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/new
  # GET /profiles/new.xml
  def new
    @profile = Profile.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @profile }
    end
  end

  # GET /profiles/1/edit
  def edit
    @profile = Profile.find(params[:id])
    @order = Order.find_by_user_id(current_user.id)
     @post = Post.new
    @user =
    #@profile = Profile.find_by_user_id(User.find_by_username(params[:slug]).id)
    @user = User.find(@profile.user_id)
    if current_user == @user
      @posts = Post.paginate_all_by_user_id(@user.followers.map(& :id).push(@user.id), :page => params[:page], :per_page => 10, :order=>'created_at desc')
    else
      @posts = Post.paginate_all_by_user_id(@user.id, :page => params[:page], :per_page => 10, :order=>'created_at desc')
    end
  end

  # POST /profiles
  # POST /profiles.xml
  def create
    @profile = Profile.new(params[:profile])

    respond_to do |format|
      if @profile.save
        flash[:notice] = 'Profile was successfully created.'
        format.html { redirect_to(@profile) }
        format.xml  { render :xml => @profile, :status => :created, :location => @profile }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /profiles/1
  # PUT /profiles/1.xml
  def update
    @profile = Profile.find(params[:id])
    @profile.user_id = current_user.id
    respond_to do |format|
      if @profile.update_attributes(params[:profile])
        flash[:notice] = 'Profile was successfully updated.'
        format.html { redirect_to(show_user_path(current_user.username)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @profile.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /profiles/1
  # DELETE /profiles/1.xml
  def destroy
    @profile = Profile.find(params[:id])
    @profile.destroy

    respond_to do |format|
      format.html { redirect_to(profiles_url) }
      format.xml  { head :ok }
    end
  end
end
