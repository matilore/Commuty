class Revision < ActiveRecord::Base
	belongs_to :request


	def self.revision_of_post(post)
		where(post_id: post.id)		
	end

	def self.number_of_revisions_per_post(post)
		where(post_id: post.id).size
	end


end
