class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { maximum:20 }
  validates :email, presence: true, length: { maximum:255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  validates :password, length: { maximum: 4 }
end
