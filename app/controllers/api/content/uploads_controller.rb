class Api::Content::UploadsController < ApiController
  private

  def model
    Content::Upload
  end

  def params_accessible
    params.require(:content_upload).permit(:name, :attachment)
  end
end
