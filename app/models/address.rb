class Address < ApplicationRecord
  belongs_to :customer

  def shipping_info
    postcode + " " + " " + address + " " + " "+ name
  end

end
