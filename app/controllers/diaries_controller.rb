class DiariesController < ApplicationController
  #before_action :authenticate_user!
  before_action :set_diary, only: [:show, :edit, :update, :destroy]
  #before_action :authorize_owner!, only: [:show, :edit, :update, :destroy]

  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)
    @diary.user_name = '名無し' if @diary.user_name.blank?

    if @diary.save
      prompt = "#{@diary.user_name}が主人公、#{@diary.content}を#{@diary.style}にして、50字以上120文字以内で出力してください。"
      openai_service = OpenaiService.new

      begin
        generated_content = openai_service.generate_indirect_message(prompt)
        Rails.logger.info "Generated content: #{generated_content}"
        @diary.update(generated_content: generated_content)
        redirect_to @diary
      rescue => e
        Rails.logger.error "Failed to generate content: #{e.message}"
        flash[:alert] = "Failed to generate content: #{e.message}"
        render :new
      end
    else
      flash[:alert] = "Failed to save diary."
      render :new
    end
  end

  def show
  end

  private

  def set_diary
    @diary = Diary.find(params[:id])
  end

  def diary_params
    params.require(:diary).permit(:user_name, :content, :style)
  end
end