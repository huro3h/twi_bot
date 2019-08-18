# frozen_string_literal: true

module TweetsHelper
  def flash_with_bootstrap(type)
    case type
    when 'success'
      'alert-success'
    when 'error'
      'alert-danger'
    when 'alert'
      'alert-warning'
    when 'notice'
      'alert-info'
    else
      'alert-secondary'
    end
  end
end
