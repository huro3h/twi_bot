class PostsController < ApplicationController
  def index
    @posts = Post.where(is_deleted: false).order(id: :desc)
    @posts = Post.page(params[:page]).per(50)
  end

  def new
  end

  def show
  end

  def edit
  end

  def create
  end

  def destroy
  end
end
