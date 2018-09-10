class VotesController < ApplicationController

	before_action :set_post, only: [:destroy]

  def create
    @vote = Vote.new(vote_params)
    @post_id = params[:vote][:post_id]

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
-Implement voting for downvotes as well
-Differentiate between voting types
-Change implementation to reflect change in voting type
-Show when the post is upvoted and have a delete form instead of create form ready when page is loaded 
end