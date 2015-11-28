class Request < ActiveRecord::Base
	belongs_to :post
	has_one :revision

	def self.show_author_requests(user_id)
		where(author_id: user_id)
	end

	def self.show_editor_requests(editor_id)
		where(editor_id: editor_id)
	end

	def self.show_number_pending_requests(user_id)
		where(author_id: user_id, status_request: false).size
	end

	def self.show_number_accepted_requests(user_id)
		where(author_id: user_id, status_request: true).size
	end

	def self.editor_accepted?(post_id, current_user)
		if current_user
			where("editor_id = ? AND post_id = ? AND status_request = ?", current_user.id, post_id, true)
		end
	end

	def self.editor_pending?(post_id, current_user)
		if current_user
			where("editor_id = ? AND post_id = ? AND status_request = ?", current_user.id, post_id, false)
		end
	end
	
end
