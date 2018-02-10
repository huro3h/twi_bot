require 'twitter'

namespace :twi_bot do
  # bundle exec rake twi_bot:tweet
  desc 'first tweet'
  task tweet: :environment do
    keys = twitter_keys
    tweet = 'First_tweet!'
    update(keys, tweet)
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