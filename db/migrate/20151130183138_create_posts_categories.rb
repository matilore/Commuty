class CreatePostsCategories < ActiveRecord::Migration
  def change
    create_table :posts_categories do |t|
    	t.belongs_to :post, index: true
    	t.belongs_to :category, index: true
    end
  end
end
