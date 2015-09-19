class PagesController < ApplicationController

  before_action :confirm_login
  before_action :find_admin
  before_action :confirm_user_page_access

  layout 'admin' 

  def index
    if session[:username] == 'super.super'
      @pages = Page.all.order('created_at desc')
    else
      @pages = @admin.pages.all.order('title asc')
    end
  end

  def show
    @page = Page.find(params[:id])
  end

  def delete
    @page = Page.find(params[:id])
  end

  def destroy
    page = Page.find(params[:id])
    page.destroy
    flash[:notice] = "Page deleted sucessfully"
    redirect_to(:action => 'index')
  end

  def edit
    @categories = Category.all.order('Name ASC')
    @page = Page.find(params[:id])
  end

  def update
    @page = Page.find(params[:id])
    if @page.update_attributes(page_parameters)
      flash[:notice] = "Page updated sucessfully"
      redirect_to(:action => 'show', :id => @page.id)
    else
      flash[:notice] = "Page could not be updated"
      @categories = Category.all.order('Name ASC')
      render('edit')
    end 
  end

  def new
    @page = Page.new
    @categories = Category.all.order('Name ASC')
  end

  def create
    @page = Page.new(page_parameters)
    @page.hit_count = 0
    if @page.save
      PageEdit.create(:page => @page, :admin_user => @admin)
      flash[:notice] = "Page created sucessfully"
      redirect_to(:action => 'show', :id => @page.id)
    else
      @categories = Category.all.order('Name ASC')
      flash[:notice] = "Page could not be created"
      render('new')
    end
  end

  def view
    @page = Page.find(params[:id])
    redirect_to(:controller => 'sections', :action => 'index' ,:page_id => @page.id)
  end

  def remove_img
    page = Page.find(params[:id])
    page.remove_image_url!
    page.image_url = "no image" 
    page.save
    redirect_to(:action => 'show', :id => page.id)
  end

  def toggleVisibility
    @page = Page.find(params[:id])
    if @page.visible == true
      @page.visible = false
    else
      @page.visible = true
    end
    if @page.save
      redirect_to(:action => 'index')
    end
  end

  private
  def page_parameters
    params.require(:page).permit(:title, :image_url, :content, :category_id, :visible)
  end

  def find_admin
    userId = session[:user_id]
    @admin = AdminUser.find(userId)
  end

  def confirm_user_page_access
    if session[:username] != 'super.super' 
      userId = session[:user_id]
      admin = AdminUser.find(userId)
      page_ids = admin.pages.pluck(:id)
      # flash[:notice] = params[:id]
      if params[:id].present?
        page1 = Page.find(params[:id])
        if !page_ids.include? page1.id 
          flash[:notice] = "Unauthorized request. Access Denied"
          redirect_to(:action => 'index')
        else
          
        end     
      end 
    end
  end
end
