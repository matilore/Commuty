class Category < ActiveRecord::Base
	has_and_belongs_to_many :posts

	def self.find_category_by_name(word)
		Category.where(name: word)
	end
end
