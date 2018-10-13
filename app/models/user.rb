class User < ApplicationRecord
    # { self.email.downcase! }でもOK
    before_save { self.email = email.downcase } # 右辺はself.email.downcaseの省略
    # 省略形：validates :name, presence: true
    # ⇨ validates(:name, {presence: true})
    validates(:name, { presence: true, length: { maximum: 50 } })
    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
    validates :email, presence: true, length: { maximum: 255 }, 
                format: { with: VALID_EMAIL_REGEX },
                uniqueness: { case_sensitive: false }
    has_secure_password
end
