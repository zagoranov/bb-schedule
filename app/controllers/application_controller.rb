class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :set_locale


  def set_locale
#    I18n.locale = params[:locale] || I18n.default_locale
     if extract_locale_from_accept_language_header == "ru"
     	I18n.locale = :ru
     else
     	I18n.locale = :en
     end
  end

helper_method :current_user

private
def current_user
  @current_user ||= User.find(session[:user_id]) if session[:user_id]
end

private 
 def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end

end
