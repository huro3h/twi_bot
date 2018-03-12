require 'twitter'

class Tweet < ApplicationRecord
  include TwitterClient

  validates :content, uniqueness: true, length: { in: 1..140 }

  def new
    client
  end
end
