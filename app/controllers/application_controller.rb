class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

    private 
  def confirm_login
  	unless session[:user_id]
  		flash[:notice] = "Please log in"
  		redirect_to(:controller => "access", :action => "login")
  		return false  # halts the before_action
  	else
  		return true
  	end
  end

  def check_admin
    # session[:username]
    if (session[:username] == "rathashit" or session[:username] == "super.super")
      return true
    else
      return false
    end
  end
end
