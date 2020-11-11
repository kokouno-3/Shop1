class Item < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :carts, dependent: :destroy
  belongs_to :genre, optional: true
  attachment :image

  enum is_status: {
    '販売中': true,
    '販売中止': false
  }

  validates :name, :explanation, :price, presence: true
end
