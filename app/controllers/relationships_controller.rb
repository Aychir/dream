class RelationshipsController < ApplicationController
  include UsersHelper
  def follow_user
    @user = User.find(params[:user])
    if((@user != current_user) && !current_user_is_following(current_user.id, @user.id))
        current_user.follow(@user.id)
        redirect_to list_followers_path(@user)
    elsif @user == current_user
        redirect_to users_path, :notice => "You cannot follow yourself..."
    else
        redirect_to users_path, :notice => "You cannot follow someone you follow..."
    end
  end

  def unfollow_user
    @user = User.find(params[:user])
    if((@user != current_user) && current_user_is_following(current_user.id, @user.id))
       current_user.unfollow(@user.id)
       redirect_to list_followers_path(@user)
    elsif @user == current_user
        redirect_to users_path, :notice => "You cannot unfollow yourself..."
    else
        redirect_to users_path, :notice => "You cannot unfollow someone you do not follow..."
    end
  end
end

#What I want to do is when follow is clicked, open index again and next to each user have the see followers button to click and verify that this works
