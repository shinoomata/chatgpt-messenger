class DiariesController < ApplicationController
  def new
    @diary = Diary.new
  end

  def create
    @diary = Diary.new(diary_params)
    @diary.user_name = '名無し' if @diary.user_name.blank?

    if @diary.save
      prompt = "#{@diary.user_name}が主人公で冒頭に挨拶、#{@diary.content}を#{@diary.style}で語ってください。出力は100字以内で。"
      openai_service = OpenaiService.new

      begin
        generated_content = openai_service.generate_indirect_message(prompt)
        Rails.logger.info "Generated content: #{generated_content}"
        @diary.generated_content = generated_content

        if @diary.save
          redirect_to @diary, notice: 'diary was successfully created.'
        else
          flash.now[:alert] = 'diary was created but failed to save generated content.'
          render :new
        end
      rescue => e
        Rails.logger.error "Failed to generate content: #{e.diary}"
        flash.now[:alert] = "Failed to generate content: #{e.diary}"
        render :new
      end
    else
      flash.now[:alert] = 'diary was not created.'
      render :new
    end
  end

  def show
    @diary = Diary.find(params[:id])
  end

  private

  def diary_params
    params.require(:diary).permit(:user_name, :content, :style)
  end
end