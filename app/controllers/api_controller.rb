class ApiController < ActionController::Base
  self.responder = ApiResponder
  before_filter :prepare_headers, :prepare_format
  before_filter :prepare_index_params, :only => :index
  respond_to :csv, :json, :xls, :xml

  def prepare_index_params
    params[:per] = if !params[:per].is_a?(Fixnum) || params[:per] < 1
      Kaminari.config.default_per_page
    elsif Kaminari.config.max_per_page < params[:per] 
      Kaminari.config.max_per_page
    end
    params[:q] ||= {}
    params[:q][:s] ||= 'updated_at desc'
  end
  
  private
  
  def prepare_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  def prepare_format
    request.format = :json if ![:csv, :json, :xls, :xml].include?(request.format)
  end
end
