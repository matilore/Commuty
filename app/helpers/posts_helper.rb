module PostsHelper

	def check_if_revision_written(request_accepted)
		if request_accepted[0].revision != nil
			request_accepted[0].revision.written == true ? true : false
		else
			false
		end		
	end

	def number_of_revisions_per_post(post)
		Revision.number_of_revisions_per_post(post)
	end
end
