class Task < ApplicationRecord
  validates :name, presenece: true
  validates :content, presenece: true
  validates :priority, presenece: true
  validates :status, presenece: true
end
