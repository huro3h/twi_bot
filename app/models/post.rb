require 'twitter'

class Post < ApplicationRecord
  include TwitterClient

  def delete_post(delete_id)
    client.destroy_status(delete_id)
  end
end
