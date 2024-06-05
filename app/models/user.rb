class User < ApplicationRecord
  has_many :diaries
  def self.find_or_create_from_auth(auth)
    user = find_or_create_by(uid: auth['uid'], provider: auth['provider'])
    user.update(
      name: auth['info']['name'],
      image: auth['info']['image']
    )
    user
  end
end
