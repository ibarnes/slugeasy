class MessagesController < ApplicationController
  # GET /messages
  # GET /messages.xml
  before_filter :require_user, :except=>:new
  
  def index
    #@messages = current_user.messages
    if params[:is_sent]
      @messages = Message.paginate_all_by_sender_id(current_user.id, :page => params[:page], :per_page => 10)
    else
      @messages = Message.paginate_all_by_receiver_id(current_user.id, :page => params[:page], :per_page => 10)
      
    
    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1
  # GET /messages/1.xml
  def show
    @messages = Message.find(params[:id])
    @receiver = User.find(@messages.receiver_id)
    @sender = User.find(@messages.sender_id)
    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/new
  # GET /messages/new.xml
  def new
    @messages = Message.new
    @user = User.find(params[:id])
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @messages }
    end
  end

  # GET /messages/1/edit
  def edit
    @messages = Message.find(params[:id])
  end

  # POST /messages
  # POST /messages.xml
  def create
    @messages = Message.new(params[:message])
    
    @user = User.find(@messages.receiver_id)
    @messages.sender_id = current_user.id
    respond_to do |format|
      if @messages.save
        Notifier.deliver_new_message(@user,@messages,current_user)
        flash[:notice] = 'Messages was successfully created.'
        format.html { redirect_to(@messages) }
        format.xml  { render :xml => @messages, :status => :created, :location => @messages }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @messages.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /messages/1
  # PUT /messages/1.xml
  def update
    @messages = Message.find(params[:id])

    respond_to do |format|
      if @messages.update_attributes(params[:message])
        flash[:notice] = 'Messages was successfully updated.'
        format.html { redirect_to(@messages) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @messages.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /messages/1
  # DELETE /messages/1.xml
  def destroy
    @messages = Message.find(params[:id])
    @messages.destroy

    respond_to do |format|
      format.html { redirect_to(messages_url) }
      format.xml  { head :ok }
    end
  end
end
