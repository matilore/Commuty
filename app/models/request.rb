class Request < ActiveRecord::Base

	def self.show_author_requests(user_id)
		where(author_id: user_id)
	end
end
