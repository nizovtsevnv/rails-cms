class Api::UsersController < ApiController
  private

  def model
    User
  end

  def params_accessible
    params.require(:user).permit(:email, :password)
  end
end
