class SitesController < ApplicationController
	def index
		@posts = Post.all.order('created_at DESC')
		if current_user
			@user_logged = true
		else
			@user_logged = false
		end
	end
end
