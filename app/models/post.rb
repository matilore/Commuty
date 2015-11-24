class Post < ActiveRecord::Base
	validates :title, presence: true, length: {minimum: 3}
	validates :content, presence: true
	belongs_to :user


end
