class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
    	t.references :post
    	t.integer :editor_id
    	t.boolean :status_request, default: false

      t.timestamps null: false
    end
  end
end
