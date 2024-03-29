class Review < ApplicationRecord
  belongs_to :list
  validates :rating, presence: true
  validates :rating, comparison: { greater_than_or_equal_to: 0, less_than_or_equal_to: 5 }
  validates :rating, numericality: { only_integer: true }
  validates :content, presence: true
end
