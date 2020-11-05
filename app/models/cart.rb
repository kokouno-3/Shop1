class Cart < ApplicationRecord
  belongs_to :item
  belongs_to :customer
  validates :amount, presence: true
end
