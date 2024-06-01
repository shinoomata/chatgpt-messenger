OpenAI.configure do |config|
    config.access_token = ENV['OPENAI_API_KEY'] || Rails.application.credentials.dig(:openai, :api_key)
  end
  