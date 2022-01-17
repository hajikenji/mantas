class Label < ApplicationRecord

  has_many :labellings
  has_many :tasks, dependent: :destroy, through: :labellings
end