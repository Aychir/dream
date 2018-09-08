class VotesController < ApplicationController

	before_action :set_post, only: [:destroy]

  def create
    @vote = Vote.new(vote_params)
    if !@vote.save
      # flash that something went wrong
      redirect_to users_path, :notice => "We were unable to process this request at this moment in time."
    end
  end

  def destroy
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
