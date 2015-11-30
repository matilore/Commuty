class PostsController < ApplicationController
	before_action :authenticate_user!, except: [:index, :show]

	def index
		user_id = params[:user_id]
		@user = User.find_by(id: user_id)		
		@posts = Post.where(user_id: user_id).order('created_at DESC')
	end

	def show
		@user = User.find_by(id: params[:user_id])
		post_id = params[:id]
		@post = @user.posts.find_by(id: post_id)
		@request = Request.new
		@comment = Comment.new



		if current_user
			@if_request_accepted = find_match_request_editor_accepted(post_id, current_user) 
			#if request exists but status = false
			find_match_request_editor_pending(post_id, current_user) ? @request_pending = true : @no_request_found = true

			if @if_request_accepted
				@request_accepted = show_accepted_request(post_id, current_user)
			end

			if if_revision_exist(@post)
			#retrieve revisions if exists
				@revisions = all_revisions_of_post(@post)
			end

		end
	end

	def new

		@user = User.find(params[:user_id])
		@post = Post.new
		
	end

	def create

		@user = User.find_by(id: params[:user_id])
		@post = @user.posts.new(post_params)
		if @post.save
			redirect_to user_posts_path(@user.id)
		else
			flash[:error] = "The post could not be added"
			redirect_to new_user_post_path
		end
	end

	def edit

			@user = User.find_by(id: params[:user_id])
			post_id = params[:id]
			@post = @user.posts.find_by(id: post_id)
		
	end

	def update

		post_id = params[:id]
		
		@user = User.find_by(id: params[:user_id])


		if current_user.id == @user.id || find_match_request_editor_accepted(post_id, current_user)
			@post = @user.posts.find_by(id: post_id)

			if @post.update(post_params)
				redirect_to user_post_path(@user.id, @post.id)
			else
				flash[:error] = "The post could not be updated"
				redirect_to edit_post_path
			end
		else
			@post = @user.posts.find_by(id: post_id)
			flash[:notice] = "Your are not allowed to edit this post"
			redirect_to edit_user_post_path(@post.user_id, @post.id)
		end
	end

	def destroy
		@user = User.find_by(id: params[:user_id])
		if current_user.id == @user.id
			@post = @user.posts.find_by(id: params[:id])
			@post.destroy
			redirect_to user_posts_path(@user.id)
		else
			@post = @user.posts.find_by(id: params[:id])
			flash[:notice] = "Your are not allowed to delete this post"
			redirect_to edit_user_post_path(@post.user_id, @post.id)
		end
	end


	private

	def post_params
		params.require(:post).permit(:title, :content)		
	end

	def find_match_request_editor_accepted(post_id, current_user)
		#this method lies in request model -> search for matches of accepted requests
		if current_user
			request_accepted_match = Request.editor_accepted?(post_id, current_user)
			request_accepted_match.size > 0 ? true : false
		end
	end

	def find_match_request_editor_pending(post_id, current_user)
		#this method lies in request model -> search for matches of accepted requests
		if current_user
			request_pending_match = Request.editor_pending?(post_id, current_user)
			request_pending_match.size > 0 ? true : false
		end
	end

	def show_accepted_request(post_id, current_user)
		if current_user
			request_accepted_match = Request.editor_accepted?(post_id, current_user)
		end		
	end

	def if_revision_exist(post)
		revision = Revision.revision_of_post(post)[0]
		
		if revision != nil
			return true
		else
			return false
		end
	end

	def all_revisions_of_post(post)
		revision = Revision.revision_of_post(post)		
	end

end
