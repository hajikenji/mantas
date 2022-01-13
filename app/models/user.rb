class User < ApplicationRecord
  has_secure_password
  validates :name, presence: true, length: { maximum:20 }
  validates :email, presence: true, length: { maximum:255 },
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  validates :password, length: { maximum: 4 }
  has_many :tasks, dependent: :destroy
  has_many :labels, dependent: :destroy

  before_update :stop_for_last1

  private

  def stop_for_last1

    if self[:admin] == false
      users = User.where.not(id: self[:id])

      # throw(:abort) if users.all?{ |u| u[:admin] == false }
      
      if users.all?{ |u| u[:admin] == false }
        errors.add(:base, "このユーザーのadminを不許可にすると管理者が0人になります。")
        throw(:abort)
      end
    end
  end

end
