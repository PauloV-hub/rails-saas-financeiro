class Category < ApplicationRecord
  belongs_to :user
  has_many :transactions, dependent: :destroy

  validates :name, presence: true, uniqueness: { scope: :user_id, message: "já existe nesta conta" }
  validates :description, length: { maximum: 500 }
end