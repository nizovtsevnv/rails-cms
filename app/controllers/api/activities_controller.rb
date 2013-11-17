class Api::ActivitiesController < ApiController
  def index
    @search = Activity.search(params[:q])
    @data = @search.result.page(params[:page]).per(params[:per])
    respond_with @data, :total => @search.result.count, :page => params[:page], :per => params[:per]
  end

  def show
    @data = Activity.find(params[:id])
    respond_with @data
  end
end
