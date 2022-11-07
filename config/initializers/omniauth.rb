OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '807546819296222', '8a5e9dd669fd0d528507699bec5985c3', {:client_options => {:ssl => {:ca_path => "/etc/ssl/certs"}}}
end