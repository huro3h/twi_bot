require 'twitter'

namespace :twi_bot do
  # bundle exec rake twi_bot:random_tweet
  desc 'random_tweet'
  task random_tweet: :environment do
    keys = twitter_keys
    tweet_id = rand(Tweet.first.id..Tweet.last.id)
    tweet = Tweet.where(id: tweet_id).first
    if tweet.present
      puts tweet.content
      update(keys, tweet.content)
    else
      Rake::Task.new('twi_bot:random_tweet', Rake.application).invoke
    end
  end

  # bundle exec rake twi_bot:tweet
  desc 'first_tweet_test'
  task test_tweet: :environment do
    keys = twitter_keys
    tweet = "First_tweet!\r改行"
    update(keys, tweet)
  end

  desc 'tweet_delete'
  task delete: :environment do
    keys = twitter_keys
    delete_id = ""
    keys.destroy_status(delete_id)
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
end

def twitter_keys
  keys = Twitter::REST::Client.new do |config|
    config.consumer_key = ENV['CONSUMER_KEY']
    config.consumer_secret = ENV['CONSUMER_SECRET']
    config.access_token = ENV['ACCESS_TOKEN']
    config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
  end
  keys
end

def update(keys, tweet)
  tweet = (tweet.length > 140) ? tweet[0..139].to_s : tweet
  keys.update(tweet.chomp)
rescue Exception => e
  Rails.logger.error "<<twitter.rake::tweet.update ERROR : #{e.message}>>"
end
