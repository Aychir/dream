class PostsController < ApplicationController

	before_action :set_post, only: [:show]

	def index
	end

	def show
		@width = @post.image.metadata[:width]
		@height = @post.image.metadata[:height]
		@ratio = @width.to_f/@height

		# if @width > 1080
		# 	puts "Width too big"
		# 	@post.image.variant(resize: "1080")
		# elsif @width < 320
		# 	puts "Width too small"
		# 	@post.image.variant(resize: "320")
		# end

		# if @ratio < 0.8
		# 	#shave vertically
		# 	puts "Height too big"
		# 	@shaveSize = @width/0.8
		# 	@post.image.variant(shave: "x#{@height - @shaveSize}")
		# elsif @ratio > 1.91
		# 	#shave horizontally
		# 	puts "Height too small"
		# 	@shaveSize = 1.91 * height;
		# 	@post.image.variant(shave: "#{@width - @shaveSize}")
		# end
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
