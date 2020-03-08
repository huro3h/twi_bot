# frozen_string_literal: true
# sandbox_code

class Music
  extend ActiveModel::Callbacks
  ATTRIBUTES = %i[title created_at listened_at]

  attr_accessor *ATTRIBUTES

  # コールバックを定義
  # 好きな名前で定義可能、プレフィックス、サフィックスで前後に処理を挟む
  define_model_callbacks :create, :play

  # before_xxxで playアクション実行前に実行
  before_play :display_title

  # after_xxxで createアクション実行後に実行
  after_create ->(music) { music.created_at = Time.current }

  def self.create(title: nil)
    music = new
    music.title = title
    music.create
  end

  def create
    # run_callbacksでcallbackの使用を明示的に宣言
    run_callbacks :create do
      puts 'つくりました'
      self
    end
  end

  def play
    # run_callbacksでcallbackの使用を明示的に宣言
    run_callbacks :play do
      puts '今から曲流しますよー'
    end
  end

  private

  # before_playのコールバック
  def display_title
    puts title
  end
end

# Music.create(title: 'title_test')
# つくりました
# => #<Music:0x00007fea5c37a778 @created_at=Sun, 08 Mar 2020 06:45:08 UTC +00:00, @title="title_test">

# music.play
# title_test
# 今から曲流しますよー
# => nil
