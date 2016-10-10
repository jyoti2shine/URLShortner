class ApplicationController < ActionController::API
   include ActionController::MimeResponds
  # include ActionController::Helpers
  # include ActionController::Cookies
  # include ActionController::ImplicitRender
  include ActionController::HttpAuthentication::Token::ControllerMethods

  def authenticate
    authenticate_token || render_unauthorized
  end

  private

  def authenticate_token
    authenticate_with_http_token do |token, options|
      @current_user = User.find_by(api_token: token)
    end
  end

  def render_unauthorized(realm = "Application")
    self.headers["WWW-Authenticate"] = %(Token realm="#{realm.gsub(/"/, "")}")
    render json: 'Bad credentials', status: :unauthorized
  end
end