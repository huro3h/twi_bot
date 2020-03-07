# frozen_string_literal: true
# sandbox_code

class Music
  extend ActiveModel::Callbacks
  ATTRIBUTES = %i[title created_at listened_at]

  attr_accessor *ATTRIBUTES
end