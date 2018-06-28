def update
    @user = User.find(params[:id])
    puts @user.email
    puts "Hello"
    if (params[:user][:email] != @user.email) && (@user.unconfirmed_email != nil)
      #if the user hasn't confirmed their email and they try to change it, give them this message
      redirect_to @user, notice: "You must first confirm your email before attempting to change to a new one"
    elsif (params[:user][:email] != @user.email) && (@user.unconfirmed_email == nil)
      respond_to do |format|
        if @user.update(user_params)
          bypass_sign_in(@user)
            #Could be an issue with efficiency, unnecessarily logging back in if it's not needed- don't think so though
          format.html { redirect_to @user, notice: "Fuck you"}
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
          format.html { redirect_to @user, notice: "Your screenname has been updated!"}
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end 