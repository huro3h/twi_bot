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
    redirect_to @tweet, notice: '作成しました' if @tweet.save
  end

  def destroy
  end

  private

  def tweet_params
    params.fetch(:tweet, {}).permit(:content)
  end
end
