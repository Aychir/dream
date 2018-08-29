class PostsController < ApplicationController

	before_action :set_post, only: [:show]

	def index
	end

	def show
		@width = @post.image.metadata[:width]
		@height = @post.image.metadata[:height]
		@ratio = @width.to_f/@height
		@type = @post.image.blob.content_type
		puts "WIDTH: #{@width}" 
  	end

  	def new
    	@post = Post.new
  	end

  	def create
    	@post = Post.new(post_params)

	    respond_to do |format|
	      if @post.save
	        format.html { redirect_to @post, notice: 'User was successfully created.' }
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
			params.require(:post).permit(:caption, :title, :image)
		end
end
