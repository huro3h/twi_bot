class PostsController < ApplicationController
  def index
    @posts = Post.where(is_deleted: false).order(id: :desc).limit(25)
  end
end
