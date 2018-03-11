class TweetsController < ApplicationController

  def index
    @tweets = Tweet.page(params[:page]).per(50)
  end

  def new
  end

  def show
  end

  def edit
  end

  def destroy
  end
end
