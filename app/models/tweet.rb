require 'twitter'

class Tweet < ApplicationRecord
  include TwitterClient

  validates :content, uniqueness: true, length: { in: 1..140 }

  def new
    client
  end

  def self.total_number_of_tweet
    Tweet.count
  end
end
