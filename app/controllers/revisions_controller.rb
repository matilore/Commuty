class RevisionsController < ApplicationController
	before_action :authenticate_user! , except: [:index]

		def show
		@revision = Revision.find_by(id: params[:id] )

		#find_editor & find_author is set in User model
		@user = User.find_editor_from_revision(@revision)
		

		#@revisions_same_post = 
		
	end

	def create

		request = Request.find(params[:request_id])
		post = Post.find(request.post_id)
		revision = Revision.new(title: post.title, content: post.content, request_id: request.id, post_id: post.id, written: true)

		if revision.save
			redirect_to edit_revision_path(revision.id)
		else
			flash[:notice] = "you couldn't add a revision"
			redirect_to "/"
		end
	end


	def edit
		@revision = Revision.find_by(id: params[:id])
	end
	
	def update
		revision_id = params[:id]

		@revision = Revision.find_by(id: revision_id)


		editor_id = Request.find_by(id: @revision.request_id).editor_id
		#if current_user_id match with editor_id in request
		if current_user.id == editor_id

			if @revision.update(title: params[:revision][:title], content: params[:revision][:content])
				redirect_to revision_path(@revision.id)
			else
				flash[:error] = "Changes has not been applied"
				redirect_to revision_path(@revision.id)
			end
		else
			author = User.find_author_from_revision(@revision)
			post = Post.find_post_from_revision(@revision)
			flash[:notice] = "Your are not allowed to edit this post"
			redirect_to user_post_path(author.id, post.id)
		end
	
		
	end

	
end
