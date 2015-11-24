class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  	
has_many :posts

	def self.show_username_by_request(user_id)
		find_by(id: user_id).username		
	end
	
end
