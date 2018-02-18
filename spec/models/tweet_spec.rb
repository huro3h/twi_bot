require 'rails_helper'

describe Tweet do
  describe 'content' do
    before do
      Tweet.create(content: '投稿テスト')
    end

    let(:dup_tweet) { Tweet.new(content: '投稿テスト') }
    let(:tweet) { Tweet.new(content: '重複していない投稿テスト') }

    it '重複したcontentは無効であること' do
      expect(dup_tweet.save).to eq(false)
    end

    it '重複していないcontentは有効であること' do
      expect(tweet.save).to eq(true)
    end
  end
end
