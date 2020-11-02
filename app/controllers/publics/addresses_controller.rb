class Publics::AddressesController < ApplicationController
  def index
    @addresses = Address.all
    @address = Address.new
    @customer = Customer.find(params[:customer_id])
  end

  def create
    @customer = Customer.find(params[:customer_id])
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to publics_customer_addresses_path
  end

  def edit
    @address = Address.find(params[:id])
    @customer = Customer.find(params[:customer_id])
  end

  def destroy
  end

  def update
  end

  private
  def address_params
    params.require(:address).permit(:postcode, :address, :name, :customer_id)
  end
end
