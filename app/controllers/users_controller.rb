class UsersController < ApplicationController
  def index
    @users = User.paginate(:page => params[:page], :per_page => 15)
  end

  def show
    @user = User.find(params[:id])
    @posts = @user.posts.all
  end
end
