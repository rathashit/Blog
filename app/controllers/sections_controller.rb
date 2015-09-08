class SectionsController < ApplicationController
  
  before_action :confirm_login
  before_action :find_page
  
  layout 'admin'

  def index
    @sections = @page.sections.order('position asc')
  end

  def show
    @section = Section.find(params[:id])
  end

  def delete
    @section = Section.find(params[:id])
  end

  def destroy
    @section = Section.find(params[:id])
    @section.destroy
    flash[:notice] = "Section deleted sucessfully"
    redirect_to(:action => 'index',  :page_id => @page.id)
  end

  def edit
    
    @section = Section.find(params[:id])
    @position_count = @page.sections.all.size
  end

  def update
    @section = Section.find(params[:id])
    @section.page_id = @page.id
    if @section.update_attributes(section_parameters)
      flash[:notice] = "Section updated sucessfully"
      redirect_to(:action => 'show', :id => @section.id, :page_id => @page.id)
    else
      @position_count = @page.sections.all.size + 1
      flash[:notice] = "Section could not be updated"
      render('edit', :page_id => @page.id)
    end
  end

  def new
    @section = Section.new
    @position_count = @page.sections.all.size + 1
  end

  def create
    @section = Section.new(section_parameters)
    @section.page_id = @page.id
    if @section.save
      flash[:notice] = "Section created sucessfully"
      redirect_to(:action => 'show', :id => @section.id, :page_id => @page.id)
    else
      @position_count = @page.sections.all.size + 1
      flash[:notice] = "Section could not be created"
      render('new', :page_id => @page.id)
    end
  end
  def remove_img
    section = Section.find(params[:id])
    section.remove_img_url!
    section.img_url = "no image" 
    section.save
    redirect_to(:action => 'show', :id => section.id, :page_id => @page.id)
  end

  private

  def section_parameters
    params.require(:section).permit(:name, :visible, :content, :img_url, :img_desc, :position, :page_id)
  end

  def find_page
    @page = Page.find(params[:page_id])
  end
end
