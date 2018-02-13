require 'twitter'

class Tweet < ApplicationRecord
  include TwitterClient

  def new
    client
  end
end
