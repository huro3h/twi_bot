class TweetsController < ApplicationController

  def index
    @tweets = Tweet.page(params[:page]).per(70).order(id: :desc)
  end

  def new
    @tweet = Tweet.new
  end

  def show
    @tweet = Tweet.find(params[:id])
  end

  def edit
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to @tweet, notice: 'tweetを作成しました'
    else
      render new, notice: '140文字以内で入力して下さい'
    end
  end

  def destroy
  end

  private

  def tweet_params
    params.fetch(:tweet, {}).permit(:content)
  end
end
