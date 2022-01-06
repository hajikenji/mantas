class Task < ApplicationRecord
  validates :name, presence: true
  validates :content, presence: true
  validates :priority, presence: true
  validates :status, presence: true
  belongs_to :user
  scope :order_time, -> { all.order(time: 'ASC') }
  scope :order_update, -> { all.order(updated_at: 'DESC') }
  scope :search_ambiguous, -> (search_name) { where('name like ?', "%#{search_name}%") }
  scope :status_index, -> (num_index) { where(status: num_index) }
  scope :priority_index, -> (num_index) { where(priority: num_index) }
  scope :order_priority, -> { all.order(priority: 'ASC') }

  enum priority: { 高: 4, 中: 5, 低: 6 }
end
