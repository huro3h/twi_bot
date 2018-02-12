class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :publish_id, unique: true
      t.string :content
      t.boolean :is_deleted, null: false, default: false
      t.datetime :deleted_at
      t.timestamps
    end
  end
end
