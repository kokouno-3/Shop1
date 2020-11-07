class Publics::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresses = Address.all
    @address = Address.new
    @customer = Customer.find_by(params[:customer_id])
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    @address.save
    redirect_to publics_addresses_path(@address.id)
  end

  def edit
    @address = Address.find(params[:id])
    @customer = current_customer
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to publics_addresses_path(@address.id)
  end

  def update
    @address = Address.find(params[:id])
    @address.customer_id = current_customer.id
    @address.update(address_params)
    redirect_to publics_addresses_path(@address)
  end

  private
  def address_params
    params.require(:address).permit(:postcode, :address, :name, :customer_id)
  end
end