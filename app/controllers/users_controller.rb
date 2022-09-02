class UsersController < ApplicationController

  before_action :set_user, only: [:edit, :update, :show, :destroy] #getting data against provided id
  before_action :check_logged_in_user, only: [:edit, :update] #check if the user is logged in or not
  before_action :require_admin, only: [:destroy] # restrict logged-in user to perform only its own actions or change-details.

  def index
    @user = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(users_params)
    if @user.save
      flash[:info] = "User #{@user.username} created"
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
      flash[:info] = "Account #{@user.username} updated"
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
    flash[:info] = "User and its articles are deleted"
    redirect_to users_path
  end

  def admin #used to grand or revoke access of admin for users
    user = User.find_by(id: params[:user_id])
    if user.admin?
      if User.all.where(admin: true).count == 1
        flash[:success] = "This is the only admin - you cannot revoke its access"
      else
        user.update(admin: false)
        flash[:success] = "Removed admin rights for user: #{user.username}"
      end
    else
      pp user
      user.update(admin: true)
      pp user
      flash[:success] = "User: #{user.username} is now an admin"
    end
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
    if !logged_in || current_user != @user
      flash[:danger] = "User not logged-in OR wrong user to perform this action"
      redirect_to root_path
    end
  end

  def require_admin #stop non-admin performing delete action
    if logged_in and !current_user.admin?
      flash[:info] = "You must have admin rights to perform this action"
      redirect_to root_path
    end
  end

end
