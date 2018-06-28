class UsersController < ApplicationController
  include UsersHelper
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  before_action :require_login, :only => [:edit, :update, :destroy] #I don't think anything else should be blocked

  def list_blockers()
    @user = User.find(params[:user])
    @blockers = @user.blockers
  end

  def list_blocking()
    @user = User.find(params[:user])
    @blocking = @user.blocking
  end

  def list_followers()
    @user = User.find(params[:user])
    @followers = @user.followers
  end

  def list_following()
    @user = User.find(params[:user])
    @following = @user.following
  end

  def change_password()
    @user = User.find(params[:user_id])
    #Adjust this to be nested param to be [:user][:id]?
    if(@user != current_user)
      redirect_to users_path, :notice => "You cannot edit another user's password..."
    end
    if(current_user.unconfirmed_email == nil)
      redirect_to edit_user_path(@user), :notice => "You must confirm your email before you are able to change your password."
    end
  end

  def change_email()
    @user = User.find(params[:user_id])
    #Adjust this to be nested param to be [:user][:id]?
    if(@user != current_user)
      redirect_to users_path, :notice => "You cannot edit another user's email..."
    end
    if(current_user.unconfirmed_email == nil)
      redirect_to edit_user_path(@user), :notice => "You must confirm your email before you are able to change it."
    end
  end

  # GET /users
  # GET /users.json
  def index
    @user = current_user
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
    @email = @user.email
    if(@user != current_user)
      redirect_to users_path, :notice => "You cannot edit another user..."
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  #Add a message if user email was changed
def update
  @user = User.find(params[:id])
  if (params[:user][:email] != @user.email) && (@user.unconfirmed_email != nil)
    #if the user hasn't confirmed their email and they try to change it, give them this message
    redirect_to @user, notice: "You must first confirm your email before attempting to change to a new one..."
  elsif (params[:user][:email] != @user.email) && (@user.unconfirmed_email == nil)
    #User has confirmed their email and decide to change their email
    respond_to do |format|
      if @user.update(user_params)
        bypass_sign_in(@user)
          #Could be an issue with efficiency, unnecessarily logging back in if it's not needed- don't think so though
        format.html { redirect_to @user, notice: "Please confirm your new email with the confirmation we have sent you."}
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  else
    respond_to do |format|
      if @user.update(user_params)
        bypass_sign_in(@user)
          #Could be an issue with efficiency, unnecessarily logging back in if it's not needed- don't think so though
        format.html { redirect_to @user}
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end 

  def update_password
    @user = User.find(params[:user_id])
    respond_to do |format|
      if @user.update_with_password(user_params)
          bypass_sign_in(@user)
          #Could be an issue with efficiency, unnecessarily logging back in if it's not needed- don't think so though
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
      else
        format.html { render 'change_password' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_email
    @user = User.find(params[:user_id])
    respond_to do |format|
      if @user.update(user_params)
          bypass_sign_in(@user)
          #Could be an issue with efficiency, unnecessarily logging back in if it's not needed- don't think so though
          format.html { redirect_to @user, notice: 'User was successfully updated.' }
          format.json { render :show, status: :ok, location: @user }
      else
        format.html { render 'change_password' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    #Only way a user can delete an account is if the user being deleted is the current user
    if @user == current_user
        @user.destroy
        respond_to do |format|
          format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
          format.json { head :no_content }
        end
    else
        redirect_to users_path, :notice => "You cannot destroy another user..."
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      if params[:user].is_a? String
        params[:user]
        #params.require(:user).permit(:username, :email, :screenname, :password, :password_confirmation)
      else
        params.require(:user).permit(:username, :email, :screenname, :password, :password_confirmation, :current_password, :unconfirmed_email)
      end
    end
end
