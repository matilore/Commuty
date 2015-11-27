class AddWrittenToRevisions < ActiveRecord::Migration
  def change
  	add_column :revisions, :written, :boolean, default: false
  end
end
