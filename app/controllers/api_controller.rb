class ApiController < ActionController::Base
  self.responder = ApiResponder
  before_filter :prepare_headers, :prepare_format
  before_filter :prepare_index_params, :only => :index
  respond_to :csv, :json, :xls, :xml

  def create
    @data ||= model.create params_accessible
    @success ||= @data.persisted?
    respond_with @data, :attributes => attr_accessible, :success => @success
  end

  def destroy
    @data ||= model.where(id_column => params[:id])
    @success ||= !@data.destroy_all.empty?
    respond_with @success, :success => :resource
  end

  def index
    @search ||= model.search(params[:q])
    if @search
      @data ||= @search.result.page(params[:page]).per(params[:per])
      @total ||= @search.result.count
    end
    respond_with @data, :total => @total, :page => params[:page], :per => params[:per], :attributes => attr_accessible
  end

  def show
    @data = model.find_by(id_column => params[:id])
    respond_with @data, :attributes => attr_accessible
  end
  
  def update
    @data ||= model.find_by(id_column => params[:id])
    @success = @data.update_attributes params_accessible
    respond_with @data, :attributes => attr_accessible, :success => @success
  end

  private

  def attr_accessible
    model.attribute_names
  end

  def id_column
    :id
  end

  def params_accessible
    params
  end
  
  def prepare_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Request-Method'] = '*'
  end

  def prepare_index_params
    params[:per] = if !params[:per].is_a?(Fixnum) || params[:per] < 1
      Kaminari.config.default_per_page
    elsif Kaminari.config.max_per_page < params[:per] 
      Kaminari.config.max_per_page
    end
    params[:q] ||= {}
    params[:q][:s] ||= 'updated_at desc'
  end

  def prepare_format
    request.format = :json if ![:csv, :json, :xls, :xml].include?(request.format)
  end
end
