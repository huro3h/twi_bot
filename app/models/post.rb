require 'twitter'

class Post < ApplicationRecord
  include TwitterClient

  def delete_oldest_post
    oldest_post = Post.where(is_deleted: false).last

    # FIX: 削除対象のツイートが既に無い場合、errorがgemから返る
    # Twitter::Error::NotFound: No status found with that ID.
    exec_delete(oldest_post.publish_id)

    if self.was_deleted?(oldest_post.publish_id)
      oldest_post.update(is_deleted: true, deleted_at: Time.zone.now)
      p "#{oldest_post.id} - tweet_id: #{oldest_post.publish_id}は正常に削除されました。"
    else
      p "エラーが発生しました"
    end
  end

  def exec_delete(tweet_id)
    client.destroy_status(tweet_id)
  end

  def was_deleted?(tweet_id)
    client.status(tweet_id).nil?
  end
end
