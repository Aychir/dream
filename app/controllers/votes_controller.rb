class VotesController < ApplicationController

	before_action :set_post, only: [:destroy]

	#before_action :require_login, :only => [ :destroy]

  def create
    @vote = Vote.new(vote_params)

    if @vote.save
      respond_to do |format|
        format.html { redirect_to users_path }
        format.js # we'll use this later for AJAX!
      end
    else
    	@vote.destroy
    end
  end

  def destroy
  	puts "destroy"
  	if !@vote.destroy
  		redirect_to users_path, :notice => "We were unable to process this request at this moment in time."
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
