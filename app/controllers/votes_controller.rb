require 'date'
class VotesController < ApplicationController

	before_action :set_vote, only: [:destroy, :update]

  def create
    @vote = Vote.new(vote_params)
    @post_id = params[:vote][:post_id]
    @post = Post.find(@post_id)
    @score = @post.votes.upvote.count - @post.votes.downvote.count + 1

    @post.hotness = hotness

    if @vote.save
      respond_to do |format|
        format.html { redirect_to users_path }
        #The response is the create.js.erb file in the votes view
        format.js
      end
    else
    	@vote.destroy #Not sure if I need a response to this failing
    end
  end

  def create_downvote
    @vote = Vote.new(vote_params)
    @post_id = params[:vote][:post_id]
    @post = Post.find(@post_id)
    @score = @post.votes.upvote.count - @post.votes.downvote.count - 1

    @post.hotness = hotness

    #Here I need to differentiate between upvote and downvote

    if @vote.save
      respond_to do |format|
        format.html { redirect_to users_path }
        format.js { render 'createDownvote.js.erb' }
      end
    else
      @vote.destroy #Not sure if I need a response to this failing
    end
  end

  def update
    #This will be the update from upvote to downvote
    @post_id = params[:vote][:post_id]
    @post = Post.find(@post_id)
    #Score hasn't updated yet so -1 to get back original score and -1 for the downvote
    @score = @post.votes.upvote.count - @post.votes.downvote.count - 2

    @post.hotness = hotness

    respond_to do |format|
      if @vote.update(vote_params)
        format.js
      else
        @vote.destroy #Not sure if I need a response to this failing
      end
    end
  end

  def update_to_upvote
    @post_id = params[:vote][:post_id]
    @vote_id = params[:vote_id]
    @vote = Vote.find(@vote_id)

    @post = Post.find(@post_id)
    #Score hasn't updated yet so +1 to get back original score and +1 for the upvote
    @score = @post.votes.upvote.count - @post.votes.downvote.count + 2

    @post.hotness = hotness

    respond_to do |format|
      if @vote.update(vote_params)
        format.js { render 'update_to_upvote.js.erb' }
      else
        @vote.destroy #Not sure if I need a response to this failing
      end
    end
  end

  def destroy
    @post_id = params[:vote][:post_id]
    @post = Post.find(@post_id)
  	if @vote.destroy
  		respond_to do |format|
        format.html { redirect_to users_path }
        #The response is the destroy.js.erb file in the votes view

        #Do this here because we cannot tell if the vote destroyed was upvote or downvote, so we must pass it after deletion
        @score = @post.votes.upvote.count - @post.votes.downvote.count
        @post.hotness = hotness
        format.js {render locals: { score: @score }}
      end
  	end
  end

	private 

	def set_vote
     @vote = Vote.find(params[:id])
  end

	def vote_params
		params.require(:vote).permit(:user_id, :post_id, :vote_type)
	end

  #Very similar to Reddit's own open source hotness algorithm
  #Article that references algorithm: https://medium.com/hacking-and-gonzo/how-reddit-ranking-algorithms-work-ef111e33d0d9
  def hotness
    order = Math.log10([@score.abs, 1].max)
    if @score > 0 then sign = 1 elsif @score < 0 then sign = -1 else sign = 0 end
    seconds = @post.created_at.to_i - 1134028003
    @hot = (sign * order + seconds / 45000).round(4)
    @vote.post.update_attributes({:hotness => @hot})
  end
end