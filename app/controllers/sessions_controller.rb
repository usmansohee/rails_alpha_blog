class SessionsController < ApplicationController

  def new
  end

  def create

    email = params[:session][:email]
    pass = params[:session][:password]

    @user = User.find_by(email: email)

    if @user && @user.authenticate(pass)
      session[:user_id] = @user.id
      flash[:success] = "Login Success"
      pp session[:user_id]
      redirect_to users_path(@user)
    else
      flash.now[:danger] = "Login Failed"
      render :new
    end

  end

  def destroy
    session[:user_id] = nil
    flash[:info] = "User Logged out"
    redirect_to root_path
  end

end