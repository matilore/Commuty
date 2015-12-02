module UsersHelper

	def revisions_per_post(post)
		if Revision.number_of_revisions_per_post(post)
		if Revision.number_of_revisions_per_post(post) != 0
			'Number of Revisions for this post ' + Revision.number_of_revisions_per_post(post).to_s
		else
			'No revisions for this post'
		end
	end
	end

end
