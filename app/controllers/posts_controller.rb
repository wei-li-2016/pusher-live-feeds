class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc) # add this line
  end

  def new
  end

  def create
  end
end
