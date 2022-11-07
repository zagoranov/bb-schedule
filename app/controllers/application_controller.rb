class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_action :set_locale

  def set_locale
#    I18n.locale = params[:locale] || I18n.default_locale
   if !I18n.locale 
     if extract_locale_from_accept_language_header == "ru"
     	I18n.locale = :ru
     else
     	I18n.locale = :en
     end
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

helper_method :get_workin_max
private
def get_workin_max(max, reps)
  delta_1 = max.to_f * reps.to_i * 0.03333 + max.to_f
  return (delta_1 / 100) * 90  
end

helper_method :round_w
private
def round_w(weight, arr)
  delta_90 = weight
  if (['4', '9'].include? delta_90.to_s.last)
    delta_90 = delta_90 + 1
  else
    while (!arr.include? delta_90.to_s.last )
      delta_90 = delta_90 - 1
    end
    if ['2', '7'].include? delta_90.to_s.last
      delta_90 = delta_90 + 0.5 
    end
  end
  return delta_90
end

def pontificate(user)
  require 'nokogiri'
  require 'open-uri'
  require 'net/https'
  @doc = Nokogiri::HTML(open("https://api.telegram.org/BOTID:BOTHASH/sendMessage?chat_id=CHATID&text=New+User+on+UserLift+" + user.username,  :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
end


end
