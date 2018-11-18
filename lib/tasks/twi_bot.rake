require 'twitter'
require 'slack-notifier'

namespace :twi_bot do
  # bundle exec rake twi_bot:random_tweet
  desc 'random_tweet'
  task random_tweet: :environment do
    client = twitter_client
    tweet_id = rand(Tweet.first.id..Tweet.last.id)
    sleep_time = rand(65..240)
    tweet = Tweet.where(id: tweet_id).first
    if tweet.present?
      sleep(sleep_time)
      p "[tweet_log] [#{Time.zone.now}] Sleep_time:[#{sleep_time}] content:[#{tweet.content.truncate(25)}]"
      update(client, tweet.content)

      # TODO: あとでメソッド切る
      # 自動で消す為にtweet内容を記録
      latest_tweet = client.user_timeline(ENV['MY_TWI_BOT']).first.to_h
      Post.create(
        publish_id: latest_tweet[:id_str],
        content: latest_tweet[:text],
        created_at: Time.zone.now
      )
    else
      notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_URL']
      notifier.ping p "[error_log] [#{Time.zone.now}] エラーが発生しました"
      # Rake::Task.new('twi_bot:random_tweet', Rake.application).invoke
    end
  end

  desc 'remove_duplicate_posts'
  task remove_duplicate_posts: :environment do
    post = Post.new
    if post.duplicate_exists?
      duplicate_post_ids = post.duplicate_exists?
      duplicate_post_ids.each do |duplicate_post_id|
        Post.where(publish_id: duplicate_post_id).each do |duplicate_post|
          duplicate_post.update(is_deleted: true, deleted_at: Time.zone.now)
        end

        post.exec_delete(duplicate_post_id)
        notifier = Slack::Notifier.new ENV['SLACK_WEBHOOK_URL']
        notifier.ping p "[duplicate] [#{Time.zone.now}] publish_id: #{duplicate_post_id} が重複していた為削除しました。"
      end
    end
  end

  # bundle exec rake twi_bot:tweet_test
  desc 'tweet_test'
  task tweet_test: :environment do
    client = twitter_client
    tweet = "tweet_test!\rand_new_line_test.."
    update(client, tweet)
  end

  # bundle exec rake twi_bot:delete_latest_post
  desc 'tweet_delete_with_Post_model_latest'
  task delete_latest_post: :environment do
    if Post.where(is_deleted: false).size > 15
      post = Post.new
      post.delete_latest_post
    end
  end

  # bundle exec rake twi_bot:read
  desc 'read_n_save'
  task read: :environment do
    File.open('tweet.txt') do |file|
      file.each_line do |tw|
        tweet = Tweet.new
        tweet.content = tw
        tweet.save
        if tweet.save
          puts "ツイート #{tw} を保存しました"
        else
          puts 'ツイートの保存に失敗しました'
          puts "失敗→ #{tw}"
        end
        sleep 0.5
      end
    end
  end

  # bundle exec rake twi_bot:read
  desc 'read_old_post_id'
  task read_post_id: :environment do
    miss_ids = []
    File.open('./public/tweet_ids.txt') do |file|
      file.each_line do |old_id|
        post = Post.new
        post.publish_id = old_id.strip!
        post.save
        if post.save
          puts "過去のツイートID #{old_id} を保存しました"
        else
          puts 'ツイートの保存に失敗しました'
          puts "失敗→ #{old_id}"
          miss_ids << old_id
        end
      end
      puts "失敗件数 #{miss_ids.count}"
      puts miss_ids if miss_ids.present?
    end
  end
end

def twitter_client
  client = Twitter::REST::Client.new do |config|
    config.consumer_key        = ENV['CONSUMER_KEY']
    config.consumer_secret     = ENV['CONSUMER_SECRET']
    config.access_token        = ENV['ACCESS_TOKEN']
    config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
  end
  client
end

def update(client, tweet)
  tweet = (tweet.length > 140) ? tweet[0..139].to_s : tweet
  client.update(tweet.chomp)
rescue Exception => e
  Rails.logger.error "<<twitter.rake::tweet.update ERROR : #{e.message}>>"
end
