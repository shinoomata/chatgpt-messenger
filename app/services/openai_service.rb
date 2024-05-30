# app/services/openai_service.rb
require 'openai'

class OpenaiService
  def initialize
    @client = OpenAI::Client.new(access_token: Rails.application.credentials.dig(:openai, :api_key))
  end

  def generate_indirect_message(prompt)
    Rails.logger.info "Generating indirect message with prompt: #{prompt}"

    response = @client.chat(
      parameters: {
        model: 'gpt-3.5-turbo',
        messages: [{role: 'user', content: prompt}]
      }
    )

    Rails.logger.info "OpenAI API response: #{response.inspect}"

    if response['choices'] && response['choices'][0] && response['choices'][0]['message'] && response['choices'][0]['message']['content']
      return response['choices'][0]['message']['content'].strip
    else
      Rails.logger.error "Unexpected API response format: #{response.inspect}"
      return "エラーメッセージ: 適切な応答を受け取れませんでした。"
    end
  end
end
