OmniAuth.config.allowed_request_methods = [:post, :get]
OmniAuth.config.silence_get_warning = true

OmniAuth.config.request_validation_phase = proc do |env|
  Rails.logger.debug "CSRF Session: #{env['rack.session']['_csrf_token']}"
  Rails.logger.debug "CSRF Params: #{env['rack.request.query_hash']['state']}"
  unless env['rack.session'] && env['rack.session']['_csrf_token'] == env['rack.request.query_hash']['state']
    fail OmniAuth::Strategies::OAuth2::CallbackError.new(:csrf_detected, 'CSRF detected')
  end
end

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
  provider :twitter2,
  ENV['TWITTER_CLIENT_ID'],
  ENV['TWITTER_CLIENT_SECRET'],
  callback_path: "/auth/twitter2/callback",
  scope: "tweet.read users.read"
else
  provider :twitter2,
           Rails.application.credentials.dig(:twitter, :client_id),
           Rails.application.credentials.dig(:twitter, :client_secret),
           callback_path: "/auth/twitter2/callback",
           scope: "tweet.read users.read"
  end
end

OmniAuth.config.logger = Rails.logger
OmniAuth.config.logger.level = Logger::DEBUG
