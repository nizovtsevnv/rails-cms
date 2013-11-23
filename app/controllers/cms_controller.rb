class CmsController < ApplicationController
  def show_application
    render :application, :layout => 'cms'
  end
  
  def show_view
    render params[:view], :layout => false
  end
end
