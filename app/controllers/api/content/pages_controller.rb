class Api::Content::PagesController < ApiController
  private

  def model
    Content::Page
  end

  def params_accessible
    params.require(:content_page).permit(:body, :description, :keywords, :locale_name, :name, :state, :title)
  end
end
