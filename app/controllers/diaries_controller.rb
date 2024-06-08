class DiariesController < ApplicationController
  # before_action :authenticate_user!
  before_action :set_diary, only: [:show, :edit, :update, :destroy]
  before_action :authorize_owner!, only: [:show, :edit, :update, :destroy]

  def new
    @diary = Diary.new
  end

  def create
    # 今日の投稿数をチェック
    if Diary.created_today(current_user).count >= 5
      @diary = Diary.new(diary_params)
      flash[:alert] = '1日に投稿できるのは5個までです。'
      render :new
      return
    end

    @diary = Diary.new(diary_params)
    @diary.user = Rails.env.production? ? current_user : User.first # 開発時に最初のユーザーを設定
    @diary.user_name = '名無し' if @diary.user_name.blank?

    if @diary.save
      prompt = "120字、#{@diary.user_name}が主人公で冒頭に挨拶、#{@diary.content}を#{@diary.style}に言い換えて出力。"
      openai_service = OpenaiService.new

      begin
        generated_content = openai_service.generate_indirect_message(prompt)
        Rails.logger.info "Generated content: #{generated_content}"
        @diary.generated_content = generated_content

        if @diary.save
          redirect_to @diary, notice: 'diary was successfully created.'
        else
          flash[:alert] = 'diary was created but failed to save generated content.'
          render :new
        end
      rescue => e
        Rails.logger.error "Failed to generate content: #{e.diary}"
        flash[:alert] = "Failed to generate content: #{e.diary}"
        render :new
      end
    else
      render :new
    end
  end

  def show
  end

  private

  def set_diary
    @diary = Diary.find(params[:id])
  end

  def authorize_owner!
    redirect_to root_path, alert: 'アクセスが許可されていません' unless owner?(@diary)
  end

  def diary_params
    params.require(:diary).permit(:user_name, :content, :style)
  end
end