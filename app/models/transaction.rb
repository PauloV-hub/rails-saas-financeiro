class Transaction < ApplicationRecord
  belongs_to :category
  belongs_to :user

  validates :description, :amount, :date, :category_id, :user_id, presence: true
  validates :amount, numericality: { other_than: 0 }
end