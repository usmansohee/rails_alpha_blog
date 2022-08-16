class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:info] = "User #{@user.username} Created Successfully"
      redirect_to articles_path
    else
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @user.update(users_params)
      flash[:info] = "Account #{@user.username} updated Successfully"
      #redirect_to user_path(@user)
      redirect_to articles_path
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def show
  end

  def destroy

  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def users_params
    params.require(:user).permit(:username, :email, :password)
  end

end
