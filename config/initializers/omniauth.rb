OmniAuth.config.allowed_request_methods = [:post, :get]
OmniAuth.config.silence_get_warning = true

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
