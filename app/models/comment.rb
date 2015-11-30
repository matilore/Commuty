class Comment < ActiveRecord::Base
  belongs_to :post

  def self.get_comment_from_post(post_id)
  	where(post_id: post_id)
  end
end
