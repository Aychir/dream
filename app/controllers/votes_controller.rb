class VotesController < ApplicationController

	before_action :set_post, only: [:destroy, :update]

  def create
    @vote = Vote.new(vote_params)
    @post_id = params[:vote][:post_id]

    #Here I need to differentiate between upvote and downvote

    if @vote.save
      respond_to do |format|
        format.html { redirect_to users_path }
        #The response is the create.js.erb file in the votes view
        format.js
      end
    else
    	@vote.destroy
    end
  end

  def create_downvote
    @vote = Vote.new(vote_params)
    @post_id = params[:vote][:post_id]

    #Here I need to differentiate between upvote and downvote

    if @vote.save
      respond_to do |format|
        format.html { redirect_to users_path }
        #The response is the create.js.erb file in the votes view
        format.js { render 'createDownvote.js.erb' }
      end
    else
      @vote.destroy
    end
  end

  def update
    #need to render createDownvote/create form so that the form points to deleting the new shit
    #When one vote is made, the other form should be a create action

    #This will be the update from upvote to downvote
    @post_id = params[:vote][:post_id]

    respond_to do |format|
      if @vote.update(vote_params)
        format.js
      else
        @vote.destroy
      end
    end
  end

  def update_to_upvote
    @post_id = params[:vote][:post_id]
    @vote_id = params[:vote_id]
    @vote = Vote.find(@vote_id)

    respond_to do |format|
      if @vote.update(vote_params)
        format.js { render 'update_to_upvote.js.erb' }
      else
        @vote.destroy
      end
    end
  end

  def destroy
    @post_id = params[:vote][:post_id]
  	if @vote.destroy
  		respond_to do |format|
        format.html { redirect_to users_path }
        #The response is the destroy.js.erb file in the votes view
        format.js
      end
  	end
  end

  def destroy_downvote
    @post_id = params[:vote][:post_id]
    @vote = Vote.find(params[:vote_id])
    if @vote.destroy
      respond_to do |format|
        format.html { redirect_to users_path }
        #The response is the destroy.js.erb file in the votes view
        format.js { render 'destroyDownvote.js.erb' }
      end
    end
  end


	private 

	def set_post
     @vote = Vote.find(params[:id])
  end

	def vote_params
		params.require(:vote).permit(:user_id, :post_id, :vote_type)
	end
end

=begin
  
So what's next?
-User not signed in shouldn't be able to vote but to open up a sign up/login dialogue?
-Implement voting for downvotes as well X
-Differentiate between voting types X
-Change implementation to reflect change in voting type
-Show when the post is upvoted and have a delete form instead of create form ready when page is loaded 
end (Upon load determine if user has upvoted or downvoted)
-If a user has upvoted and then clicks the downvote, it must create a downvote and delete the upvote

=end