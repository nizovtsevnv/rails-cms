class PagesController < ApplicationController
  before_filter :set_locale

  def index
    # Search pages in a list of switched on, has current locale, filtered and ordered by params
    params[:q] ||= {}
    params[:q][:s] ||= 'updated_at desc'
    @search = Content::Page.on.localized(I18n.locale).search(params[:q])
    @pages = @search.result.page(params[:page])
    # Select a hash name->body of widgets without link to any page
    @widgets = Content::Widget.to_hash Content::Widget.common.localized(I18n.locale)
    respond_with @pages
  end
  
  def show
    # Root page is named 'en', or other defined locale
    params[:name] = I18n.locale if params[:name].nil?
    # Render the page if it switched on and has current locale
    if @page = Content::Page.on.localized(I18n.locale).find_by_name(params[:name])
      # Select a hash name->body of widgets
      @widgets = Content::Widget.to_hash Content::Widget.localized(I18n.locale).for(@page)
      respond_with @page
    else
      render '/404', :status => 404
    end
  end
end
