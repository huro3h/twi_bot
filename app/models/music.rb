# frozen_string_literal: true
# sandbox_code

class Music
  extend ActiveModel::Callbacks
  ATTRIBUTES = %i[title created_at listened_at]

  attr_accessor *ATTRIBUTES

  # コールバックを定義
  define_model_callbacks :create, :play

  before_play :display_title
  after_create ->(music) { music.created_at = Time.current }

  def self.create(title: nil)
    music = new
    music.title = title
    music.create
  end

  def create
    run_callbacks :create do
      puts 'つくりました'
      self
    end
  end

  def play
    run_callbacks :play do
      puts '今から曲流しますよー'
    end
  end

  private

  def display_title
    puts title
  end
end
