class ApiController < ActionController::Base
  self.responder = ApiResponder
  before_filter :prepare_headers, :prepare_format
  respond_to :csv, :json, :xls, :xml

  private
  
  def prepare_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  def prepare_format
    request.format = :json if ![:csv, :json, :xls, :xml].include?(request.format)
  end
end
