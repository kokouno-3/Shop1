class Order < ApplicationRecord
  has_many :order_details, dependent: :destroy
  belongs_to :customer

  validates :postcode, :address, :name, presence: true

   enum pay_way: {
    クレジット: 0,
    銀行振込: 1
  }

   enum status: {
    入金待ち: 0,
    入金確認: 1,
    製成中: 2,
    発送準備中: 3,
    発送済み: 4
  }

  #validates :order, acceptance: true
  #validates :order, presence: true
  #validates :order, inclusion: {in: [0, 1, 2]}
end
