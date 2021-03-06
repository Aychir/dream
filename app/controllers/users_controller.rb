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
    if(@user != current_user)
      redirect_to users_path, :notice => "You cannot edit another user's password..."
    end
    if(@user.confirmed? == false)
      @user.send_confirmation_instructions
      redirect_to edit_user_path(@user), :notice => "You must confirm your email before you are able to change your password. We have resent the confirmation email."
    end
  end

  def change_email()
    @user = User.find(params[:user_id])
    if(@user != current_user)
      redirect_to users_path, :notice => "You cannot edit another user's email..."
    end
    if(@user.confirmed? == false)
      @user.send_confirmation_instructions
      redirect_to edit_user_path(@user), :notice => "You must confirm your email before you are able to change it. We have resent the confirmation email."
    end
  end

  def change_username()
    @user = User.find(params[:user_id])
    if(@user != current_user)
      redirect_to users_path, :notice => "You cannot edit another user's username..."
    end
    if(@user.confirmed? == false)
      @user.send_confirmation_instructions
      redirect_to edit_user_path(@user), :notice => "You must confirm your email before you are able to change your username. We have resent the confirmation email."
    end
  end

  def sports
    @user = current_user
    @users = User.all
  end

  def funny
    @user = current_user
    @users = User.all
  end

  def gaming
    @user = current_user
    @users = User.all
  end

  def music
    @user = current_user
    @users = User.all
  end

  def pictures
    @user = current_user
    @users = User.all
  end

  def wtf
    @user = current_user
    @users = User.all
  end

  def food
    @user = current_user
    @users = User.all
  end

  def animals
    @user = current_user
    @users = User.all
  end

  def news
    @user = current_user
    @users = User.all
  end

  def learning
    @user = current_user
    @users = User.all
  end

  def fitness
    @user = current_user
    @users = User.all
  end

  def nsfw
    @user = current_user
    @users = User.all
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
  respond_to do |format|
    if @user.update(user_params)
      bypass_sign_in(@user)
        #Could be an issue with efficiency, unnecessarily logging back in if it's not needed- don't think so though
      format.html { redirect_to @user, notice: "Your screenname has updated."}
      format.json { render :show, status: :ok, location: @user }
    else
      format.html { render :edit }
      format.json { render json: @user.errors, status: :unprocessable_entity }
    end
  end
end

  def update_password
    @user = User.find(params[:user_id])
    respond_to do |format|
      if @user.update_with_password(user_params)
          bypass_sign_in(@user)
          #Could be an issue with efficiency, unnecessarily logging back in if it's not needed- don't think so though
          format.html { redirect_to @user, notice: 'Password was successfully updated.' }
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
          format.html { redirect_to @user, notice: 'Confirm your new email with the confirmation we sent to finalize the change.' }
          format.json { render :show, status: :ok, location: @user }
      else
        format.html { render 'change_email' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def update_username
    @user = User.find(params[:user_id])
    respond_to do |format|
      if @user.update(user_params)
          bypass_sign_in(@user)
          #Could be an issue with efficiency, unnecessarily logging back in if it's not needed- don't think so though
          format.html { redirect_to @user, notice: 'Username was successfully updated!' }
          format.json { render :show, status: :ok, location: @user }
      else
        format.html { render 'change_username' }
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
