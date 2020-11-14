class Publics::AddressesController < ApplicationController
  before_action :authenticate_customer!

  layout 'publics/header'
  def index
    address = current_customer.addresses.all
    @addresses = address.page(params[:page]).per(6)
    @address = Address.new
    @customer = current_customer
  end

  def create
    @address = Address.new(address_params)
    @address.customer_id = current_customer.id
    if @address.save
      redirect_to addresses_path #(@address.id)
    else
      @addresses = Address.all
      @customer = current_customer
      render :index
    end
  end

  def edit
    @address = Address.find(params[:id])
    @customer = current_customer
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_to addresses_path(@address.id)
  end

  def update
    @address = Address.find(params[:id])
    @address.customer_id = current_customer.id
    if @address.update(address_params)
      redirect_to addresses_path(@address)
    else
      @customer = current_customer
      render :edit
    end
  end

  private
  def address_params
    params.require(:address).permit(:postcode, :address, :name, :customer_id)
  end
end