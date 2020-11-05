class Address < ApplicationRecord
  belongs_to :customer

  def shipping_info
    # [postcode] + [address] + [name]
    postcode + " " + " " + address + " " + " "+ name
  end

end
