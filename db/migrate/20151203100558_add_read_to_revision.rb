class AddReadToRevision < ActiveRecord::Migration
  def change
  	add_column :revisions, :read, :boolean, default: false
  end
end
