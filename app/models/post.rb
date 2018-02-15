require 'twitter'

class Post < ApplicationRecord
  include TwitterClient

  def delete_oldest_post
    oldest_post_tweet_id = Post.where(is_deleted: false).last.publish_id

    if self.was_deleted?(oldest_post_tweet_id)
      p "対象のツイートは既に削除されています → #{oldest_post_tweet_id}"
    else
      exec_delete(oldest_post_tweet_id)
      p "削除 → #{oldest_post_tweet_id}"
    end
    oldest_post_tweet = Post.find_by(publish_id: oldest_post_tweet_id)
    oldest_post_tweet.update(is_deleted: true, deleted_at: Time.zone.now)
  end

  def exec_delete(tweet_id)
    client.destroy_status(tweet_id)
  end

  def was_deleted?(tweet_id)
    client.status(tweet_id)
    return false
  rescue Twitter::Error::NotFound # => e
    return true
  end
end
