Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter2,
           ENV['TWITTER_CLIENT_ID'],
           ENV['TWITTER_CLIENT_SECRET'],
           callback_path: "/auth/twitter2/callback",
           scope: "tweet.read users.read"
           provider_ignores_state: !Rails.env.production?
end

OmniAuth.config.logger = Rails.logger
OmniAuth.config.logger.level = Logger::DEBUG
OmniAuth.config.allowed_request_methods = [:post, :get]
