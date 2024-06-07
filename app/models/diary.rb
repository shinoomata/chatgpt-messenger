class Diary < ApplicationRecord
    belongs_to :user
    validates :content, presence: { message: "1文字以上入力してください" }, length: { maximum: 200, message: "200文字以下で入力してください"  }

    scope :created_today, ->(user) { where(user: user, created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day) }
end
