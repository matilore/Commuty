class AddReferenceRequestToRevision < ActiveRecord::Migration
  def down
  	remove_column :revisions, :request_id
  end

  def up
  	add_reference :revisions, :requests, index: true
  end
end
