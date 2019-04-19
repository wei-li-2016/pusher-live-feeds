class PostsController < ApplicationController
  def index
    @posts = Post.all.order(created_at: :desc) # add this line
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.likes.build()
    respond_to do |format|
      if @post.save
        format.json { render :show, status: :created}
      else
        format.json { render json: @chat.errors, status: :unprocessable_entity}
      end
    end
  end

  def add_like
    @post = Post.find(params[:post_id])
    if @post
      @post.likes[0].like_count +=1

      if @post.likes[0].save
        respond_to do |format|
          format.json { render :show, status: :ok}
        end
      end
    end
  end

  private
  def post_params
    params.require(:post).permit(:post, :username)
  end
end
