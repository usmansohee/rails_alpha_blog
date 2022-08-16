class ApplicationController < ActionController::Base

  helper_method :current_user, :logged_in?

  def current_user
    # if session exists then find from User (model)
    #  ||= if already exist then return existing value -else find and assign to @current_user var then return (1st comment)
    puts "-----------------------------current user---------------------------------------------"
    puts session[:user_id]
    @current_usr ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    # double !! - return true if current_user we have/exist current_user else false
     puts "-----------------------------logged in------------------------------------------------"
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "User not Logged in"
      redirect_to root_path
    end
  end

end
