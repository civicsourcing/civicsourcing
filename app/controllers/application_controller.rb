class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions
  include ActionController::MimeResponds
  include AbstractController::Translation

  before_filter :authenticate_user_from_token!

  def render_validation_errors errors
    render json: {errors: errors.to_hash}, status: 422
  end
 
  private
  
  def authenticate_user_from_token!
    token = request.headers['auth-token'].to_s
    email = request.headers['auth-email'].to_s
    return unless token && email

    user = User.find_by_email(email)
 
    if user && Devise.secure_compare(user.authentication_token, token)
      sign_in user, store: false
    end
  end

end
