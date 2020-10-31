class Item < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :carts, dependent: :destroy
  belongs_to :genre
  attachment :image
end
