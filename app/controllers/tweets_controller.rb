class TweetsController < ApplicationController
  before_action :set_tweet, only: %i[show edit update destroy]

  def index
    @tweets = Tweet.page(params[:page]).order(id: :desc)
  end

  def new
    @tweet = Tweet.new
  end

  def show
  end

  def edit
  end

  def create
    @tweet = Tweet.new(tweet_params)
    if @tweet.save
      redirect_to @tweet, notice: 'tweetを作成しました'
    else
      render :new, notice: 'エラーが発生しました'
    end
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to @tweet, notice: "#{@tweet.id}を更新しました"
    else
      render :edit
    end
  end

  def destroy
    @tweet.destroy
    redirect_to root_url
  end

  private

  def tweet_params
    params.fetch(:tweet, {}).permit(:content)
  end

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end
end
