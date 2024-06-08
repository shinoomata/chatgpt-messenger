OmniAuth.config.allowed_request_methods = %i[get post]
OmniAuth.config.silence_get_warning = true

Rails.application.config.middleware.use OmniAuth::Builder do
  if Rails.env.production?
  provider :twitter2,
           ENV['TWITTER_CLIENT_ID'],
           ENV['TWITTER_CLIENT_SECRET'],
           callback_path: "/auth/twitter2/callback",
           scope: "tweet.read users.read"
  else
  provider :developer unless Rails.env.production?
  end
end

OmniAuth.config.logger = Rails.logger
OmniAuth.config.logger.level = Logger::DEBUG
