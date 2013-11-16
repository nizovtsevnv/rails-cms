class ApplicationController < ActionController::Base
  respond_to :html
  before_filter :set_locale
  
  def set_locale
    # Set locale from selected source only for existing locales
    if locale = Locale.find(
        params[:locale] ||
        session[:locale] ||
        request.env['HTTP_ACCEPT_LANGUAGE'].to_s[0, 2].downcase ||
        I18n.default_locale
      )
      I18n.locale = session[:locale] = locale.name
    end
  end
end
