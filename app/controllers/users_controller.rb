class UsersController < ApplicationController
	before_action :authenticate_user!, only: [:show]

	def index
		@users = User.all
	end

	def show
		user_id = params[:id].to_i
		if current_user.id == user_id
			@user = User.find_by(id: params[:id])
			@user_requests = Request.show_author_requests(@user.id)
		else
			flash[:notice] = "You are logged in but you tried to access restricted content"
			redirect_to "/"
		end	
	end
end
