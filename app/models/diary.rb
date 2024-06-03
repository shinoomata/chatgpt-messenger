class Diary < ApplicationRecord
    validates :content, presence: { daiary: "入力してください" }, length: { maximum: 200 }, presence: true
end
