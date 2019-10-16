class FriendshipsController < ApplicationController
  before_action :friendship
  def index
    @friendships = current_user.all_friends
  end

  def create
    @friendship = current_user.friendships.new(:friend_id => params[:id])
    if @friendship.save
      flash[:notice] = "Sent Friend Request"
      redirect_to users_path
    end
  end

  def destroy
    @friendship.destroy
    flash[:error] = "Removed Friend"
    redirect_to users_path
  end

  def accept_request
    @friendship.status = "accept"
    @friendship.save
    flash[:notice] = "Accept Request"
    redirect_to users_path
  end

  private
    def friendship
      @friendship = Friendship.find_by(user_id: current_user.id, friend_id: params[:id].to_i)|| Friendship.find_by(friend_id:current_user.id, user_id: params[:id].to_i)
    end
end
