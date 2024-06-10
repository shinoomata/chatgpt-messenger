require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.asset_host = 'https://chatgpt-messenger-2.onrender.com'

  config.cache_classes = true
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true

  config.public_file_server.enabled = ENV["RAILS_SERVE_STATIC_FILES"].present? || ENV["RAILS_ENV"] == 'production'

  config.assets.compile = false

  config.active_storage.service = :local

  config.log_level = :info
  config.log_tags = [ :request_id ]
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.log_formatter = ::Logger::Formatter.new

  if ENV["RAILS_LOG_TO_STDOUT"].present?
    logger           = ActiveSupport::Logger.new(STDOUT)
    logger.formatter = config.log_formatter
    config.logger    = ActiveSupport::TaggedLogging.new(logger)
  end

  config.hosts << "chatgpt-messenger-2.onrender.com"
  config.active_record.dump_schema_after_migration = false

  config.middleware.use OmniAuth::Builder do
    provider :twitter2,
             ENV['TWITTER_CLIENT_ID'],
             ENV['TWITTER_CLIENT_SECRET'],
             callback_path: "/auth/twitter2/callback",
             scope: "tweet.read users.read"
  end
end
