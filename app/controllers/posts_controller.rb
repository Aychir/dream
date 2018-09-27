class PostsController < ApplicationController
	include VotesHelper

	before_action :set_post, only: [:show, :edit, :update]

	def index
	end

	def show
		@width = @post.image.metadata[:width]
		@height = @post.image.metadata[:height]
		@ratio = @width.to_f/@height
		@type = @post.image.blob.content_type
		@postId = @post.id
		@vote = Vote.new
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

  	def update
  		@post.tags_will_change!
  		parse_tags_on_update
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
    	@post = current_user.posts.new(post_params)

    	parse_tags

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

		#algorithm to parse tags for post creation
		def parse_tags
			puts @post.tags[0]
			#make the tag lowercase for consistency
    		@post.tags[0].downcase

    		#parsing the input for hashtags, and making an array of it
    		@post.tags = @post.tags[0].split("\#")

    		#Take off the first element if splitting it makes an empty string at first index 
    		@post.tags.shift if @post.tags[0] == ""

    		#remove all nonalphanumeric characters in every string
    		@post.tags.each do |tag|
    			tag.gsub!(/\p{^Alnum}/, '')
    		end
		end

		#algorithm to parse tags when updating post
		def parse_tags_on_update
			@tags = params[:post][:tags]
			@tags = @tags[0].split("\#")

			@post.tags.replace(@tags)
  			@post.save!
		end
end
