class AddIndexToTweet < ActiveRecord::Migration[5.1]
  def change
    add_index :tweets, :content, unique: true
  end
end
