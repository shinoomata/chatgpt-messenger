require 'openai'

class OpenaiService
  def initialize
    api_key = Rails.application.credentials.dig(:openai, :api_key)
    raise "API key not found" if api_key.nil?
    Rails.logger.info "Using OpenAI API key: #{api_key.inspect}"
    @client = OpenAI::Client.new(access_token: api_key)
  end

  def generate_indirect_message(prompt)
    Rails.logger.info "Generating indirect message with prompt: #{prompt}"

    begin
      response = @client.chat(
        parameters: {
          model: 'gpt-3.5-turbo',
          messages: [{ role: 'user', content: prompt }]
        }
      )

      Rails.logger.info "OpenAI API response: #{response.inspect}"

      if response['choices'] && response['choices'][0] && response['choices'][0]['message'] && response['choices'][0]['message']['content']
        return response['choices'][0]['message']['content'].strip
      else
        Rails.logger.error "Unexpected API response format: #{response.inspect}"
        return "エラーメッセージ: 適切な応答を受け取れませんでした。"
      end
    rescue Faraday::UnauthorizedError => e
      Rails.logger.error "UnauthorizedError: #{e.message}"
      return "エラーメッセージ: 認証エラーが発生しました。APIキーを確認してください。"
    rescue => e
      Rails.logger.error "GeneralError: #{e.message}"
      return "エラーメッセージ: エラーが発生しました。詳細を確認してください。"
    end
  end
end
