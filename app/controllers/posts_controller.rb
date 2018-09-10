class PostsController < ApplicationController
	include VotesHelper

	before_action :set_post, only: [:show]

	def index
	end

	def show
		@width = @post.image.metadata[:width]
		@height = @post.image.metadata[:height]
		@ratio = @width.to_f/@height
		@type = @post.image.blob.content_type
		@postId = @post.id
		@vote = Vote.new
  	end

  	def new
    	@post = current_user.posts.build
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

		def parse_tags
			#make the tag lowercase for consistency
    		@post.tags[0].downcase

    		#parsing the input for hashtags
    		@post.tags = @post.tags[0].split("\#")

    		#Take off the first element if splitting it makes an empty string at first index
    		@post.tags.shift if @post.tags[0] == ""

    		#remove all nonalphanumeric characters in every string
    		@post.tags.each do |tag|
    			tag.gsub!(/\p{^Alnum}/, '')
    		end
		end
end
