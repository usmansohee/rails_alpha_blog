class ApplicationController < ActionController::Base

  # important methods:
  # used these methods to restricting access of logged-in user and non-logged in users in UI - by using them views
  helper_method :current_user, :logged_in

  def current_user
    # if session exists then find from User (model)
    #  ||= if already exist then return existing value -else find and assign to @current_user var then return (1st comment)
    puts "-----------------------------current user---------------------------------------------"
    puts "current session status: #{session[:user_id]}"
    #@current_usr ||= User.find_by(id: session[:user_id]) if session[:user_id]

    #@current_user will be nil initaiilay when called it will go in else by default first time
    if @current_usr #if current_user have some valid value
      puts "@currnet_usr value: "
      puts @current_usr.inspect
      puts "if in current user"
      @current_usr
    else
      puts "else in current user"
      if session[:user_id]
        puts "else if in current user to--if have session"
        @current_usr = User.find_by(id: session[:user_id])
        @current_usr
      end
    end
  end

  def logged_in
    # double !! - return true if current_user we have/exist current_user else false
     puts "-----------------------------logged in------------------------------------------------"
     puts current_user
     #!!current_user
     if current_user
       true
     else
       false
     end
  end

  def require_user
    if !logged_in
      flash[:danger] = "User not Logged in"
      redirect_to root_path
    end
  end

end
