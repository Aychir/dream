class PostsController < ApplicationController
	include VotesHelper

	before_action :set_post, only: [:show, :edit, :update, :destroy]

	def index
	end

	#Not much going on here, just assigning variables
	def show
		@width = @post.image.metadata[:width]
		@height = @post.image.metadata[:height]
		#get the aspect ratio of the image for the various cropping rules for showing a post
		@ratio = @width.to_f/@height

		#returns image or video, depending on content type
		@type = @post.image.blob.content_type

		@postId = @post.id

		#Need this to generate a form for the votes in showing of post
		@vote = Vote.new

		#The displayed score for the post, the actual value is the 'hotness' value associated to a post when voted upon
		@score = @post.votes.upvote.count - @post.votes.downvote.count
  	end

  	def new
    	@post = current_user.posts.build
  	end

  	def edit
  		#Need to check that the current user is the one that made the post, otherwise just render the form to change the post
  		if(@post.user.id != current_user.id)
  			redirect_to root_path, :notice => "You cannot edit another user's post!"
  		end
  	end

  	def destroy
    #Only way a user can delete a post is if the post being deleted belongs to current user
    if @post.user.id == current_user.id
        @post.destroy
        respond_to do |format|
          format.html { redirect_to users_url, notice: 'Post was successfully destroyed.' }
          format.json { head :no_content }
        end
    else
        redirect_to users_path, :notice => "You cannot destroy another user's post..."
    end
  end

  	def update
  		#required because the form turns tags from an array of strings into a string again
  		parse_tags
  		respond_to do |format|
		    if @post.update(update_post_params)
		      format.html { redirect_to @post, notice: "Your post has been updated."}
		      format.json { render :show, status: :ok, location: @post }
		    else
		      format.html { render :edit }
		      format.json { render json: @post.errors, status: :unprocessable_entity }
		    end
  		end
  	end

  	def create
  		#build the post with all parameters passed from the creation form
    	@post = current_user.posts.new(post_params)

    	#make the tags from the form lowercase for consistency as we prepare to turn the 
    	#    string of tags from the form into an array of tags
    	@post.tags[0].downcase

    	#parse the string into an array of tags
    	if(Post.was_attached)
    		parse_tags
    	end

	    respond_to do |format|
	      if @post.save
	        format.html { redirect_to @post, notice: 'Your post was successfully created!' }
	        format.json { render :show, status: :created }
	      else
	        format.html { render :new }
	        format.json { render json: @post.errors, status: :unprocessable_entity }
	      end
	    end
  	end

	private

		def set_post
      		@post = Post.find(params[:id])
   		end

		def post_params
			params.require(:post).permit(:caption, :title, :image, tags: [])
		end

		def update_post_params
			#Need this because update would ignore the transition of tags from string to array and would save tags as one whole string
			params.require(:post).permit(:caption, :title, :image)
		end

		#algorithm to parse tags when updating or creating post
		def parse_tags
			@tags = params[:post][:tags]

			#parsing the input for hashtags, and making an array of it
			@tags = @tags[0].split("\#")

			#remove all nonalphanumeric characters in every string
			@tags.each do |tag|
    			tag.gsub!(/\p{^Alnum}/, '')
    		end

    		#remove any tags that are empty
    		@tags.reject! {|tag| tag == ""}

    		#re-add the hashtag symbol to the now parsed array of tags
    		#I did this for ease of output in update form and for diplaying tags when we will display them in show in the future
    		@tags.each_with_index do |tag, index|
    			@tags[index] = "#" + tag
    		end

    		#replace the entire array with the parsed result, @tags
			@post.tags.replace(@tags)
  			@post.save!
		end
end
