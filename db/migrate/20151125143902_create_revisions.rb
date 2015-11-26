class CreateRevisions < ActiveRecord::Migration
  def change
    create_table :revisions do |t|
    	t.string :title
    	t.text :content
    	t.references :request

      t.timestamps null: false
    end
  end
end
