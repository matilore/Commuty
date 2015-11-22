class PostsController < ApplicationController
		def index
		@posts = Post.all.order('created_at DESC')
	end

	def show
		post_id = params[:id]
		@post = Post.find_by(id: post_id)
		
	end

	def new
		@post = Post.new
		
	end

	def create
		@post = Post.new(post_params)
		if @post.save
			redirect_to posts_path
		else
			flash[:error] = "The post could not be added"
		end
	end

	private
	def post_params
		params.require(:post).permit(:title, :content)		
	end
end
