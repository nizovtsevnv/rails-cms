class Api::ActivitiesController < ApiController
  def index
    params[:q] ||= {}
    params[:q][:s] ||= 'updated_at desc'
    @search = Activity.search(params[:q])
    @data = @search.result.page(params[:page])
    respond_with @data
  end

  def show
    @data = Activity.find(params[:id])
    respond_with @data
  end
end
