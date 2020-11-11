class Publics::CustomersController < ApplicationController
  before_action :authenticate_customer!
  layout 'publics/header'

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    @customer.update(customer_params)
    redirect_to customer_path(current_customer.id)
  end

  def unsubscribe
    @customer = current_customer
  end

  def withdraw
    @customer = current_customer
    @customer.update(is_deleted: '退会済み')
    reset_session
    redirect_to customers_sign_in_path
  end

private
  def customer_params
    params.require(:customer).permit([:first_name, :last_name, :first_name_kana, :last_name_kana, :postcode, :address, :phonenumber])
  end
end
