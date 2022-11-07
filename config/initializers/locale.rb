I18n.load_path += Dir[Rails.root.join('lib', 'locale', '*.{rb,yml}')]
I18n.enforce_available_locales = false 
I18n.available_locales = [:ru, :en]
I18n.default_locale = :ru

