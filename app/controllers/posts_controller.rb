class PostsController < ApplicationController

  def index 
    @posts = Post.all 
  end

  def new 
    @post = Post.new
  end

  def create
    @post = Post.new(create_params.merge(user_id: session[:user_id]))
    if @post.save
      redirect_to posts_path
    else
      render :new
    end
  end

  private
    def create_params
      params.require(:post).permit(:title, :body)
    end

end
