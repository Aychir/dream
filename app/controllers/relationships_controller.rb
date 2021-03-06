class RelationshipsController < ApplicationController
  include UsersHelper

  before_action :require_login 

  #after_action :store_location

  #I have handled cases of signed in users trying to (un)follow themselves or invalidly redo the action after (un)following
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
  
  def block_user
    @user = User.find(params[:user])
    if((@user != current_user) && !current_user_is_blocking(current_user.id, @user.id))
        current_user.block(@user.id)
        redirect_to list_blockers_path(@user)
    elsif @user == current_user
        redirect_to users_path, :notice => "You cannot block yourself..."
    else
        redirect_to users_path, :notice => "You cannot block someone you have already blocked..."
    end
  end

  def unblock_user
    @user = User.find(params[:user])
    if((@user != current_user) && current_user_is_blocking(current_user.id, @user.id))
       current_user.unblock(@user.id)
       redirect_to list_blockers_path(@user)
    elsif @user == current_user
        redirect_to users_path, :notice => "You cannot unblock yourself..."
    else
        redirect_to users_path, :notice => "You cannot unblock someone you do not block..."
    end
  end
end

#What I want to do is when follow is clicked, open index again and next to each user have the see followers button to click and verify that this works
