class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  	
	has_many :posts

	has_attached_file :avatar, :styles => { :medium => "500x500>", :thumb => "300x300#" }, :default_url => "/images/:style/missing.png"
  	validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/

	def self.show_username_by_request(user_id)
		find_by(id: user_id).username		
	end

	def self.find_editor_from_revision(revision)
		request = Request.find_by(id: revision.request_id)
		user = User.find_by(id: request.editor_id)		
	end

	def self.find_author_from_revision(revision)
		request = Request.find_by(id: revision.request_id)
		user = User.find_by(id: request.author_id)		
	end
	
	
end
