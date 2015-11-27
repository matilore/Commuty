class Post < ActiveRecord::Base
	validates :title, presence: true, length: {minimum: 3}
	validates :content, presence: true
	
	belongs_to :user
	has_many :requests

	def self.find_post_from_revision(revision)
		find_by(id: Request.find_by(id: revision.request_id).post_id)
		
		
	end
end
