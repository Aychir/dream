class VotesController < ApplicationController

	before_action :set_post, only: [:destroy]

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
		params.require(:vote).permit(:user_id, :post_id)
	end
end

=begin
  
So what's next?
-User not signed in shouldn't be able to vote but to open up a sign up/login dialogue?
-Implement voting for downvotes as well X
-Differentiate between voting types
-Change implementation to reflect change in voting type
-Show when the post is upvoted and have a delete form instead of create form ready when page is loaded 
end (Upon load determine if user has upvoted or downvoted)
-If a user has upvoted and then clicks the downvote, it must create a downvote and delete the upvote

=end