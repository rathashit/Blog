class AdminsController < ApplicationController
 
  layout 'admin'
  
  before_action :confirm_login
  before_action :confirm_admin

  def index
    @admins = AdminUser.all.order("first_name asc")
  end

  def edit
    @admin = AdminUser.find(params[:id])
  end

  def update
    @admin = AdminUser.find(params[:id])
    if @admin.update_attributes(admin_params)
      flash[:notice] = "Details updated sucessfully"
      redirect_to(:action => "show", :id => @admin.id)
    else
      flash[:notice] = "Something went wrong"
      render('edit')
    end
  end

  def show
    @admin = AdminUser.find(params[:id])
  end

  def delete
    @admin = AdminUser.find(params[:id])
  end

  def destroy
    @admin = AdminUser.find(params[:id])
    @admin.destroy
    flash[:notice] = "User deleted sucessfully"
    redirect_to(:action => 'index')
  end

  def new
    @admin = AdminUser.new
  end

  def create
    @admin = AdminUser.new(admin_params)
    if @admin.save
      flash[:notice] = "User created sucessfully"
      redirect_to(:action => "show", :id => @admin.id)
    else
      flash[:notice] = "Something went wrong"
      render('new')
    end
  end

  private

  def confirm_admin
    if check_admin == false
      flash[:notice] = "Unauthorized Access Denied"
      redirect_to(:action => 'index', :controller => 'Access')
    end  
  end

  def admin_params
    params.require(:admin).permit(:first_name, :last_name, :username, :email, :password, :password_confirmation)
  end
end
