class RequestsController < ApplicationController
	before_action :authenticate_user!

	def index
		
	end

	def create
		@request = Request.create(request_params)
		redirect_to user_post_path(@request.author_id, @request.post_id)
		flash[:notice] = "Your request has been sent"
	end

	def update
		request = Request.find_by(id: params[:id])
		request.update(status_request: true)
		redirect_to user_path(current_user.id)
	end

	def destroy
		request = Request.find_by(id: params[:id])
		request.destroy
		redirect_to user_path(current_user.id)
	end

	private
	def request_params
		params.require(:request).permit(:editor_id, :post_id, :author_id)	
	end
end
