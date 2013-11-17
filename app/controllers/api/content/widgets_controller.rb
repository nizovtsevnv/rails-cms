class Api::Content::WidgetsController < ApiController
  private

  def model
    Content::Widget
  end

  def params_accessible
    params.require(:content_widget).permit(:body, :name)
  end
end
