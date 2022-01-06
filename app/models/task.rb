class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  belongs_to :user
  scope :order_time, -> { all.order(time: 'ASC') }
  scope :order_update, -> { all.order(updated_at: 'DESC') }
  scope :search_ambiguous, -> (search_name) { where('name like ?', "%#{search_name}%") }
  scope :status_0_index, -> { where(status: '0') }
  scope :status_1_index, -> { where(status: '1') }
  scope :status_2_index, -> { where(status: '2') }
end
