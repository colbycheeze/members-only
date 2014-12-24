class PostsController < ApplicationController
  before_action :check_login, only: [:new, :create]

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.valid?
      flash[:notify] = "New Post Created"
      redirect_to posts_path
    else
      flash.now[:error] = "Invalid entry!"
      render :new
    end
  end

  def index
    @posts = Post.all
  end

  private
    def post_params
      params.require(:post).permit(:body)
    end

    def check_login
      redirect_to login_path unless logged_in?
    end
end
