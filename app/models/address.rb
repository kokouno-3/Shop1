class Address < ApplicationRecord
  belongs_to :customer

  def shipping_info
    postcode + " " + " " + address + " " + " "+ name
  end

  validates :address, :name, presence: true
  validates :postcode, presence: true, format: { with: /\A\d{7}\z/ }
end
