I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
I18n.enforce_available_locales = false 
I18n.available_locales = [:ru, :en]
I18n.default_locale = :ru

if extract_locale_from_accept_language_header == "ru"
  	I18n.locale = :ru
else
  	I18n.locale = :en
end

private 
 def extract_locale_from_accept_language_header
    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/).first
  end