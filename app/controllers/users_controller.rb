class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show]
  before_action :check_logged_in_user, only: [:edit, :update]
  before_action :require_admin, only: [:destroy]

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
      session[:user_id] = @user.id
      redirect_to user_path(@user)
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
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash[:info] = "User deleted and its articles"
    redirect_to users_path
  end

  private

  def set_user
    @user = User.find_by(id: params[:id])
  end

  def users_params
    params.require(:user).permit(:username, :email, :password)
  end

  def check_logged_in_user
    if current_user != @user
      flash[:danger] = "you are allowed to perform action on only your account"
      redirect_to root_path
    end
  end

  def require_admin #stop non-admin performing delete action
    if logged_in and !current_user.admin?
      flash[:info] = "only admin can delete the user"
      redirect_to root_path
    end
  end

end
