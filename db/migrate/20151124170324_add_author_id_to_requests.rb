class AddAuthorIdToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :author_id, :integer
  end
end
