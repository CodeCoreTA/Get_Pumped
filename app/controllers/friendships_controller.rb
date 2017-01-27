class FriendshipsController < ApplicationController
  before_action :authenticate_user!

  def show
    @friend = Friendship.find(params[:id]).friend
    @exercises = @friend.exercises
  end

  def create
    friend         = User.find(params[:friend_id])
    new_friendship = friendship_params.merge(user_id: current_user.id)

    unless current_user.follows_or_same?(friend)
      Friendship.create(new_friendship)
    end

    redirect_to root_path
  end

  def destroy
    @friendship = Friendship.find(params[:id])
    if @friendship.destroy
      flash[:success] = "#{@friendship.friend.full_name} unfollowed."
    else
      flash[:danger] = "#{@friendship.friend.full_name} could not be
      unfollowed."
    end
    redirect_to user_exercises_path(current_user)
  end

  private

  def friendship_params
    params.permit(:friend_id, :user_id)
  end
end