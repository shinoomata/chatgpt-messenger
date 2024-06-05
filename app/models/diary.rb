class Diary < ApplicationRecord
    belongs_to :user
    validates :content, presence: { daiary: "入力してください" }, length: { maximum: 200 }, presence: true
end
