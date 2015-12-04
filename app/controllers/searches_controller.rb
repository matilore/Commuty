class SearchesController < ApplicationController

	def index
		@search_term = params[:search]
		if params[:search] != ""
			@posts = Post.search(params[:search]).order("created_at DESC")
		end

		category_id = Category.find_category_by_name(@search_term)
		posts_ids = category_id.map {|category_id| CategoriesPost.find_by(category_id: category_id).post_id}
		@posts_by_category = posts_ids.map{|post_id| Post.find_by(id: post_id)}
	end
end
