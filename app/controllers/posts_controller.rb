class PostsController < ApplicationController
  before_action :check_login, only: [:new, :create]

  def new
  end

  def create
  end

  def index
  end

  private
    def check_login
      redirect_to login_path unless logged_in?
    end
end
