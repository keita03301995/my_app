class User < ActiveRecord::Base

  # 小文字にしてデータベースに保存
  before_save { email.downcase! }
  
  # 名前のバリデーションの設定
  validates :name, presence: true, length: { maximum: 50 }

  # メールアドレスのバリデーションの設定
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                      format: { with: VALID_EMAIL_REGEX },
                        uniqueness: { case_sensitive: false }

  # secureなパスワードに
  has_secure_password

  # パスワードのバリデーションの設定
  validates :password, presence: true, length: { minimum: 6 }
end
