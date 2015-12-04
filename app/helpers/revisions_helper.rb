module RevisionsHelper

	def author_original_post_of_revision(revision)
		post = Post.find_by(id: revision.post_id)
		user = User.find_by(id: post.user_id)
		user.id

		
	end
end
