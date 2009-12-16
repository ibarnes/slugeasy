class RelationshipsController < ApplicationController

 
  def create
    @relationship = current_user.relationships.build(:follower_id => params[:follower_id])
    if @relationship.save
      flash[:notice] = "Following!"
      redirect_to(current_user)
    else
      flash[:notice] = "Already Following!!"
      redirect_to(current_user)
    end
  end

  def destroy
    @relationship =  current_user.relationships.find(params[:id])
    @relationship.destroy
    flash[:notice] = 'Removed Relationship!'
    redirect_to(current_user)
  end
end