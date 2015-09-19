class AccessController < ApplicationController
  
  layout 'admin'
  
  before_action :confirm_login, :except => [:login, :logout, :attempt_login]

  def index
    @admin1 = check_admin

  end
  def login
    render :layout => "admin_login"
  end

  def attempt_login

  	if params[:username].present? && params[:password].present?
  		user = AdminUser.where(:username => params[:username]).first
  		
  		if user
  			auth_user = user.authenticate(params[:password])
  		end
  	else

  	end
  	if auth_user
  		session[:name] = auth_user.first_name + " " + auth_user.last_name
  		session[:user_id] = auth_user.id
  		session[:username] = auth_user.username
  		flash[:notice] = "#{session[:name]}, you have logged in sucessfully"
  		redirect_to(:action => 'index')
  	else
  		flash[:notice] = "Username/Password combination incorrect"
  		redirect_to(:action => "login")
  	end
  end

  def logout
  	session[:name] = nil
  	session[:user_id] = nil
  	session[:username] = nil
    flash[:notice] = "You have logged out successfully"
  	redirect_to(:action => 'login')
  end


end
