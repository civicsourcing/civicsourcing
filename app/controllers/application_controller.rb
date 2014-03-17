class ApplicationController < ActionController::API
  include CanCan::ControllerAdditions
  include ActionController::MimeResponds
  include AbstractController::Translation

  before_filter :authenticate_user_from_token!

  def current_user
    current_api_v1_user
  end
 
  private
  
  def authenticate_user_from_token!
    token = request.headers['auth-token'].to_s
    return unless token

    user = User.find_by(authentication_token: token)
    sign_in user if user
  end

end
