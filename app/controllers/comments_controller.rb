class CommentsController < ApplicationController

	def create
		comment = Comment.new(comment_params)
		post = Post.find((params[:comment][:post_id]).to_i)
		if params[:comment][:content] != ""
			if comment.save
				flash[:notice] = 'your comment has been saved'
				redirect_to user_post_path(post.user_id, post.id) 
			end
		else
			flash[:alert] = 'Your comment has been not saved because empty'
			redirect_to user_post_path(post.user_id, post.id)
		end
	end



	def show_per_post
		#la pagina viene caricata con i relativi commenti per post
		post_id = params[:post_id].to_i		
		@comments = Comment.get_comment_from_post(post_id)
		render json: @comments		
	end

	private
		def comment_params
			params.require(:comment).permit(:content, :user_id, :post_id, :username, :paragraph_id)
			
		end
end
