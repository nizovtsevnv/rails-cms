class Api::LocalesController < ApiController
  private

  def id_column
    :name
  end
  
  def model
    Locale
  end

  def params_accessible
    params.require(:locale).permit(:name, :title)
  end
end
