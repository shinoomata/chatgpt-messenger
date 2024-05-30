# app/controllers/messages_controller.rb
class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.save
      prompt = "次のメッセージをTO（#{@message.receiver}）に遠回しに日本語で伝えてください: #{@message.content}"
      openai_service = OpenaiService.new
      generated_content = openai_service.generate_indirect_message(prompt)
      Rails.logger.info "Generated content: #{generated_content}"
      @message.generated_content = generated_content
      @message.save
      redirect_to @message, notice: 'Message was successfully created.'
    else
      render :new, notice: 'Message was not created.'
    end
  end

  def show
    @message = Message.find(params[:id])
  end

  private

  def message_params
    params.require(:message).permit(:sender, :receiver, :content)
  end
end
