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
			redirect_to new_post_path
		end
	end

	def edit
		post_id = params[:id]
		@post = Post.find_by(id: post_id)
		
	end

	def update
		post_id = params[:id]
		@post = Post.find_by(id: post_id)
		if @post.update(post_params)
			redirect_to post_path(@post.id)
		else
			flash[:error] = "The post could not be updated"
			redirect_to edit_post_path
		end		
	end

	def destroy
		post_id = params[:id]
		@post = Post.find_by(post_id)
		@post.destroy
		redirect_to posts_path
	end


	private
	def post_params
		params.require(:post).permit(:title, :content)		
	end
end
