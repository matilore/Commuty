class AddPostReferenceToRevisions < ActiveRecord::Migration
  def change
  	add_reference :revisions, :post, index: true
  end
end
