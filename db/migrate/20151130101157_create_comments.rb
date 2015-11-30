class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.integer :user_id
      t.references :post, index: true, foreign_key: true
      t.text :content
      t.string :paragraph_id

      t.timestamps null: false
    end
  end
end
