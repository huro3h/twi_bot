require 'twitter'

class Tweet < ApplicationRecord
  include TwitterClient

  validates :content, uniqueness: true

  def new
    client
  end
end
