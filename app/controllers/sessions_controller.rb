class SessionsController < ApplicationController
  #skip_before_action :verify_authenticity_token, only: [:auth_twitter2, :create]
  def new
    Rails.logger.debug "Session: #{session.to_hash}"
  end


  def create
    @diary = Diary.new(diary_params)
    @diary.user_name = '名無し' if @diary.user_name.blank?

    if @diary.save
      prompt = "#{@diary.user_name}が主人公、#{@diary.content}を#{@diary.style}にして、80字以上120文字以内で出力してください。"
      openai_service = OpenaiService.new

      begin
        generated_content = openai_service.generate_indirect_message(prompt)
        Rails.logger.info "Generated content: #{generated_content}"
        @diary.update(generated_content: generated_content)
        redirect_to @diary, notice: 'Diary was successfully created.'
      rescue => e
        Rails.logger.error "Failed to generate content: #{e.message}"
        flash[:alert] = "Failed to generate content: #{e.message}"
        render :new
      end
    else
      render :new
    end
  end

  def destroy
    reset_session
    redirect_to root_path, status: :see_other
  end

  def failure
    redirect_to root_path, alert: 'ログインに失敗しました'
  end
end
