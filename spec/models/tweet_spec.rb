require 'rails_helper'

describe Tweet do
  describe 'content' do
    before do
      Tweet.create(content: '投稿テスト')
    end

    let(:dup_tweet) { Tweet.new(content: '投稿テスト') }
    let(:tweet) { Tweet.new(content: '重複していない投稿テスト') }
    let(:tweet_over140) { Tweet.new(content: 'a' * 141) }
    let(:tweet_just140) { Tweet.new(content: 'a' * 140) }

    it '重複したcontentは無効であること' do
      expect(dup_tweet.save).to eq(false)
    end

    it '重複していないcontentは有効であること' do
      expect(tweet.save).to eq(true)
    end

    it '141文字以上は入力できないこと' do
      expect(tweet_over140.save).to eq(false)
    end

    it '140文字までは入力可能なこと' do
      expect(tweet_just140.save).to eq(true)
    end
  end
end
