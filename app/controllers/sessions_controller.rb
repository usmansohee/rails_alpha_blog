class SessionsController < ApplicationController

  def new
  end

  def create

    email = params[:session][:email]
    pass = params[:session][:password]

    @user = User.find_by(email: email)

    if @user && @user.authenticate(pass) # using authenticate() method from bcrypt to check valid
      session[:user_id] = @user.id # assigning session current user_id
      flash[:success] = "Login Success"
      redirect_to user_path(@user)
    else
      flash.now[:danger] = "Login Failed"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil #destroying session in logout
    flash[:info] = "User Logged out"
    redirect_to root_path
  end

end