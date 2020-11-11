class Cart < ApplicationRecord
  belongs_to :item
  belongs_to :customer

  validates :amount, inclusion: { in: 1..10 }
end
