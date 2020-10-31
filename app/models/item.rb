class Item < ApplicationRecord
  has_many :order_details, dependent: :destroy
  has_many :carts, dependent: :destroy
  belongs_to :genre, optional: true
  attachment :image

  #validates :name, :explanation, :price, presence: true

end
