class RemoveRequestsIdFromRevision < ActiveRecord::Migration
  def change
  	remove_column :revisions, :requests_id 
  end
end
