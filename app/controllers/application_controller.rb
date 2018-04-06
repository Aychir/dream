class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper :all
  
  before_action :configure_permitted_parameters, if: :devise_controller?
 
  #What's nice about this is that I can choose where to put it, makes it easier to add this to actions and have one less thing to worry about 
  def require_login
    unless user_signed_in?
      redirect_to new_user_session_path, :notice => "You must be logged in to access this..."
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def after_sign_in_path_for(resource)
  	users_path
    #note this won't work for users that are missing information (i.e. early users that haven't received usernames)
  end
       

  
end

#add screen name to users
#allow users to create a screen name at sign up
  #Check that this is valid- and it does not need to be unique
  #May need to set length limit on this and username
#allow users to edit their email, password, or screen name
