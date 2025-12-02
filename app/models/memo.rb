# app/models/memo.rb
class Memo < ApplicationRecord
  belongs_to :user
end

# app/models/user.rb
class User < ApplicationRecord
  # Devise モジュールの記述
  has_many :memos, dependent: :destroy
end
