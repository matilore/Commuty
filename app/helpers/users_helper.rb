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


	def show_number_of_revisions_as_editor()
		requests = Request.where('editor_id =? AND status_request =?', current_user.id, true)
		revisions = requests.map {|request| Revision.where('request_id =? AND written =?', request.id, true)} 
		revisions = revisions.reject {|revision| revision.empty?}
		revisions.size		
	end

end
