class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:show]

	def index
		@users = User.all
	end

	def show
		user_id = params[:id].to_i
		#this page is only accessible by user in the path
		if current_user.id == user_id
			@user = User.find_by(id: params[:id])
			@number_pending_requests = Request.show_number_pending_requests(@user.id)
			@user_requests = Request.show_author_requests(@user.id)
			@posts = Post.where(user_id: @user.id).order(created_at: :desc)
			@revisions = show_user_revision
			@revisions_my_posts = show_user_posts_revisions
			@my_pending_requests = show_user_pending_requests
			@my_accepted_requests = show_user_accepted_requests
			@new_user = User.new
			
		else
			flash[:notice] = "You are logged in but you tried to access restricted content"
			redirect_to "/"
		end	
	end



	private
	def show_user_revision
		requests = Request.where("editor_id =? AND status_request =?", current_user.id, true)
		requests_id = requests.map {|req| req.id}
		revisions = requests_id.map {|req_id| Revision.where("request_id =? AND written =?", req_id, true)}
		revisions[0]
	end

	def show_user_posts_revisions
		posts = Post.where(user_id: @user.id)
		posts_id = posts.map{|post| post.id}
		requests = posts_id.map {|id|Request.where("post_id =? AND status_request =?", id, true)}
		requests = requests.reject {|request| request.empty?}

		if requests.empty? != true
			revisions = requests[0].map {|request| Revision.where('request_id =? AND written =?', request.id, true)}
			revisions[0]
		end
	end


	def show_user_pending_requests
		my_pending_requests = Request.where("editor_id = ? AND status_request = ?", current_user.id, false)
		if my_pending_requests.empty? == false
			my_pending_requests
		else
			nil
		end
	end

	def show_user_accepted_requests
		my_accepted_requests = Request.where("editor_id = ? AND status_request = ?", current_user.id, true)
		if my_accepted_requests.empty? == false
			my_accepted_requests
		else
			nil
		end
	end


end
