require 'twitter'

class Post < ApplicationRecord
  include TwitterClient

  def duplicate_exists?
    posts = Post.where(is_deleted: false).pluck(:publish_id)
    p posts.group_by { |i| i }.reject { |k, v| v.one? }.keys
  end

  def delete_latest_post
    latest_post_tweet_id = Post.find_by(is_deleted: false).publish_id

    if self.was_deleted?(latest_post_tweet_id)
      puts "対象のツイートは既に削除されています → #{latest_post_tweet_id}"
    else
      exec_delete(latest_post_tweet_id)
      puts "[delete_log] [#{Time.zone.now}] 削除TweetID:[#{latest_post_tweet_id}]"
    end

    latest_post_tweet = Post.find_by(publish_id: latest_post_tweet_id)
    latest_post_tweet.update(is_deleted: true, deleted_at: Time.zone.now)
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
