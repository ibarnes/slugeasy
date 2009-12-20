class PostsController < ApplicationController
  # GET /posts
  # GET /posts.xml


  def index
    @posts = Post.paginate :page => params[:page], :per_page => 10, :order=>'created_at desc'
    if params[:fr_search] != nil
      @posts = Post.paginate(:all, :page => params[:page],:per_page => 10, :order=>'created_at desc', :conditions => ['fr_location LIKE ? ',"%#{params[:fr_search]}%"])
      @search = params[:fr_search]
    elsif params[:to_search] != nil
      @posts = Post.paginate(:all, :page => params[:page],:per_page => 10, :order=>'created_at desc', :conditions => ['to_location LIKE ?' ,"%#{params[:to_search]}%"])
      @search = params[:to_search]
    elsif params[:search] != nil
      @posts = Post.paginate(:all, :page => params[:page],:per_page => 10, :order=>'created_at desc', :conditions => ['fr_location LIKE ? or to_location LIKE ?', "%#{params[:search]}%","%#{params[:search]}%"])
      @search = params[:search]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  def drivers
     @posts = Post.paginate(:all, :page => params[:page],:per_page => 10, :order=>'created_at desc',:conditions => ['need = "2"'])
    if params[:fr_search] != nil
      @posts = Post.paginate(:all, :page => params[:page],:per_page => 10, :order=>'created_at desc', :conditions => ['need = "2" and fr_location LIKE ? ' ,"%#{params[:fr_search]}%"])
      @search = params[:frsearch]
    elsif params[:to_search] != nil
      @posts = Post.paginate(:all, :page => params[:page],:per_page => 10, :order=>'created_at desc', :conditions => ['need = "2"  and to_location LIKE ?', "%#{params[:to_search]}%"])
      @search = params[:to_search]
    elsif params[:search] != nil
      @posts = Post.paginate(:all, :page => params[:page],:per_page => 10, :order=>'created_at desc', :conditions => ['need = "2"  and fr_location LIKE ? or to_location LIKE ?', "%#{params[:search]}%","%#{params[:search]}%"])
      @search = params[:search]    
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end

  def passengers
     @posts = Post.paginate(:all, :page => params[:page],:per_page => 10, :order=>'created_at desc',:conditions => ['need = "1"'])
    if params[:fr_search] != nil
      @posts = Post.paginate(:all, :page => params[:page],:per_page => 10, :order=>'created_at desc', :conditions => ['need = "1" and fr_location LIKE ? ' ,"%#{params[:fr_search]}%"])
      @search = params[:fr_search]
    elsif params[:to_search] != nil
      @posts = Post.paginate(:all, :page => params[:page],:per_page => 10, :order=>'created_at desc', :conditions => ['need = "1" and to_location LIKE ?',"%#{params[:to_search]}%"])
      @search = params[:to_search]
    elsif params[:search] != nil
      @posts = Post.paginate(:all, :page => params[:page],:per_page => 10, :order=>'created_at desc', :conditions => ['need = "1" and fr_location LIKE ? or to_location LIKE ?', "%#{params[:search]}%","%#{params[:search]}%"])
      @search = params[:search]
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @posts }
    end
  end
  # GET /posts/1
  # GET /posts/1.xml
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.xml
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.xml
  def create
    @post = current_user.posts.build(params[:post])
    
    @fr_location = Location.find_or_create_by_title(@post.fr_location)
    @to_location = Location.find_or_create_by_title(@post.to_location)
    respond_to do |format|
      if @post.save
        flash[:notice] = 'Post was successfully created.'
        format.html { redirect_to(show_user_path(current_user.username)) }
        format.xml  { render :xml => @post, :status => :created, :location => @post }
      else
        flash[:warning] = 'Please fill in both <b>from</b> and <b>to</b> locations!'
        format.html {redirect_to(show_user_path(current_user.username))}
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.xml
  def update
    @post = Post.find(params[:id])
    @post.user_id = current_user.id
     @fr_location = Location.find_or_create_by_title(@post.fr_location)
    @to_location = Location.find_or_create_by_title(@post.to_location)
    respond_to do |format|
      if @post.update_attributes(params[:post])
        flash[:notice] = 'Post was successfully updated.'
        format.html { redirect_to(root_url) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.xml
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to(posts_url) }
      format.xml  { head :ok }
    end
  end
end
