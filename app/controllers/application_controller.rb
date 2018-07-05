 class ApplicationController < ActionController::Base
  protect_from_forgery

  helper :all
  
  before_action :configure_permitted_parameters, if: :devise_controller?

  before_action :store_location, except: [:edit, :new, :create, :show]

  before_action :authenticate_user!, except: [:show, :index, :list_followers, :list_blocking, :list_following]

  #For some reason doesn't affect edit in the users controller

  def store_location
  # store last url - this is needed for post-login redirect to whatever the user last visited.
  if (request.fullpath != "/users/sign_in" &&
      request.fullpath != "/users/password/new" &&
      request.fullpath != "/users/sign_up" &&
      request.fullpath != "/users/password" &&
      request.fullpath != "/users/sign_out" &&
      !request.xhr?) # don't store ajax calls
    session["user_return_to"] = request.fullpath 
  end
end
 
  #What's nice about this is that I can choose where to put it, makes it easier to add this to actions and have one less thing to worry about 
  def require_login
    if (request.fullpath != "/users/sign_in" &&
      request.fullpath != "/users/password/new" &&
      request.fullpath != "/users/sign_up" &&
      request.fullpath != "/users/password" &&
      request.fullpath != "/users/sign_out" &&
      !request.xhr?) # don't store ajax calls
    session["user_return_to"] = request.fullpath 
  end
    unless user_signed_in?
      redirect_to new_user_session_path, :notice => "You must be logged in to access this..."
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:username, :email, :password, :password_confirmation, :remember_me, :current_password]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
    #devise_parameter_sanitizer.permit :password_update, keys: [:password, :password_confirmation, :current_password]
  end

  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_path
    #note this won't work for users that are missing information (i.e. early users that haven't received usernames)
  end

  
end
